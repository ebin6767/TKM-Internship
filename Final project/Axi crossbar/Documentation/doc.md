<img width="1245" height="591" alt="17822016270907423676128194679377" src="https://github.com/user-attachments/assets/fabaa73c-95a1-4d10-bc61-b73cf43d269b" />

<img width="1249" height="584" alt="17822016525844981838456674480048" src="https://github.com/user-attachments/assets/eceb5ee7-e39b-4e2c-bfc4-58310e73e481" />

<img width="1252" height="585" alt="17822017159361643659355073521763" src="https://github.com/user-attachments/assets/00fe1902-e887-4751-9cff-5004370c7448" />

<img width="1242" height="196" alt="17822017397071270313203927260378" src="https://github.com/user-attachments/assets/d161edb8-9435-49b7-89b6-3cec072f71b8" />


<img width="863" height="425" alt="17822017678416675071756341636953" src="https://github.com/user-attachments/assets/27a06db1-9dd6-44e9-8ad2-4cc5f00697db" />

# AXI4 Crossbar with Adaptive Fairness Arbitration and Reliability Enhancements

## Project Overview

This project extends an open-source AXI4/AXI4-Lite Crossbar Interconnect by introducing adaptive arbitration, runtime monitoring, response error tracking, and transaction timeout handling. In addition to the design enhancements, a comprehensive verification framework was developed to validate functionality, protocol compliance, fairness, reliability, and performance under heavy traffic conditions.

The original crossbar provides configurable M×N AXI interconnect functionality with round-robin arbitration, buffering, clock-domain crossing support, and memory-map based routing. Our work enhances the design with fault-awareness, runtime observability, and improved fairness between competing masters.

---

## Original Crossbar Features

* Configurable M×N master/slave interfaces
* AXI4 and AXI4-Lite support
* Master/slave buffering capability
* Configurable outstanding transaction depth
* Clock Domain Crossing (CDC) support
* Round-robin arbitration
* Configurable priority levels
* Memory-map based routing
* Access restriction through routing tables
* USER signal support on all AXI channels

### Architecture

```text
┌─────────────┬───┬──────────────────────────┬───┬─────────────┐
│             │ S │                          │ S │             │
│             └───┘                          └───┘             │
│ ┌───────────────────────────┐  ┌───────────────────────────┐ │
│ │      Slave Interface      │  │      Slave Interface      │ │
│ └───────────────────────────┘  └───────────────────────────┘ │
│               │                              │               │
│               ▼                              ▼               │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │                         Crossbar                         │ │
│ └──────────────────────────────────────────────────────────┘ │
│               │                              │               │
│               ▼                              ▼               │
│ ┌───────────────────────────┐  ┌───────────────────────────┐ │
│ │     Master Interface      │  │     Master Interface      │ │
│ └───────────────────────────┘  └───────────────────────────┘ │
│             ┌───┐                          ┌───┐             │
│             │ M │                          │ M │             │
└─────────────┴───┴──────────────────────────┴───┴─────────────┘
```

---

# Design Enhancements

The following modules were developed and integrated into the crossbar architecture:

```text
axicb_req_logger.sv
axicb_resp_monitor.sv
axicb_fairness_arbiter.sv
```

These additions improve:

* Fairness among competing masters
* Runtime traffic visibility
* Error detection and monitoring
* Fault recovery through timeouts
* Debugging and performance analysis

---

## 1. Request Logger (`axicb_req_logger.sv`)

### Motivation

The original design lacked visibility into traffic patterns and request distribution among masters.

### Implementation

The logger passively monitors:

```text
AWVALID && AWREADY
ARVALID && ARREADY
```

for each master interface.

Whenever a successful address handshake occurs, the corresponding request counter is incremented.

### Outputs

```text
req_count[i]
```

A monitoring window may be reset using:

```text
window_clear
```

### Benefits

* Traffic profiling
* Runtime statistics collection
* Arbitration analysis
* Performance debugging

---

## 2. Response Monitor (`axicb_resp_monitor.sv`)

### Motivation

The original implementation forwarded responses without tracking failures.

### Monitored Signals

#### Write Response Channel

```text
BVALID
BREADY
BRESP
```

#### Read Response Channel

```text
RVALID
RREADY
RRESP
```

Whenever:

```text
SLVERR (2'b10)
DECERR (2'b11)
```

is detected, an error event is recorded.

### Tracked Information

#### Write Channel

```text
b_error_count
b_error_flag
```

#### Read Channel

```text
r_error_count
r_error_flag
```

### Benefits

* Immediate error visibility
* Runtime reliability statistics
* Easier debug and validation

---

## 3. Write Transaction Timeout Support

### Problem

The original write switch exposed timeout configuration parameters but did not implement timeout recovery.

A stalled slave could indefinitely block write transactions.

### Solution

When a write request is issued:

1. Start timeout counter
2. Wait for B-channel response
3. Generate timeout response if limit is exceeded

### Generated Response

```text
BRESP = DECERR
```

### Benefits

* Deadlock prevention
* Recovery from unresponsive slaves
* Guaranteed forward progress

---

## 4. Read Transaction Timeout Support

### Problem

Read requests could stall indefinitely if a slave never returned data.

### Solution

When a read request is accepted:

1. Start timeout counter
2. Wait for read response
3. Generate synthetic response on timeout

### Generated Response

```text
RRESP = SLVERR
RLAST = 1
```

### Benefits

* Fault tolerance
* Forward progress guarantee
* Improved system robustness

---

# Adaptive Fairness Arbiter

The original design relies on:

```text
Round-Robin + Static Priority Arbitration
```

While fair in most situations, highly active masters can dominate the bus for extended periods.

To improve fairness, an adaptive arbitration mechanism was introduced around the existing round-robin arbiter.

---

## Normal Mode

Operation remains identical to the original implementation:

```text
Round-Robin + Priority Arbitration
```

---

## Fairness Mode

The arbiter tracks:

```text
dominance_cnt
dominant_master
```

When:

```text
dominance_cnt >= DOMINANCE_LIMIT
```

the dominant master is temporarily blocked.

Remaining requesters are granted access until:

```text
served_mask == requester_mask
```

After all waiting masters are serviced, normal arbitration resumes.

### Key Signals

```text
dominance_cnt
dominant_master

fairness_mode
blocked_master
served_mask
```

### Advantages

* Reduced starvation risk
* Improved fairness
* Better behavior under asymmetric traffic

---

# Integration

### Data Flow

```text
Master Requests
      │
      ▼
Request Logger
      │
      ▼
Adaptive Fairness Arbiter
      │
      ▼
Crossbar Switching Logic
      │
      ▼
Slave Devices
      │
      ▼
Response Monitor
      │
      ▼
Master Interfaces
```

The logger provides traffic statistics, the arbiter manages fairness, and the response monitor tracks transaction failures and timeout-generated errors.

---

# Verification Framework

A complete SystemVerilog-based verification environment was developed to validate functionality, protocol compliance, fairness mechanisms, timeout recovery, and system robustness.

The verification environment models a 4×4 AXI system using independent master and slave agents.

## Verification Methodology

### Modular Agents

Independent channel-level drivers and responders for:

```text
AW Channel
W Channel
B Channel
AR Channel
R Channel
```

### Stress Testing

The environment focuses on corner-case traffic patterns including:

* Starvation floods
* Matrix congestion
* Slave backpressure
* Arbitration stress
* Timeout scenarios

### Protocol Validation

The framework validates:

* AXI handshakes
* Ordering behavior
* Non-blocking operation
* Response correctness
* Fair arbitration

---

## Verification Components

### AXICB Master Driver (`axicb_master_driver.sv`)

Generates AXI burst transactions.

Example task:

```text
drive_write_burst(addr, burst_len, master_id)
```

Verifies:

* Burst handling
* Arbitration
* Ordering
* Routing correctness

### Adaptive Arbiter Monitor

Validates:

* Dominance detection
* Fairness-mode activation
* Fairness-mode exit
* Dynamic arbitration behavior

### AXI Response Monitor

Checks:

```text
SLVERR
DECERR
```

responses and validates error tracking logic.

### Timeout Detector

Monitors:

* Read timeout counters
* Write timeout counters
* Correct timeout response generation

---

# Verification Scenarios

## 1. Starvation Flood

### Objective

Validate fairness under extreme priority imbalance.

### Procedure

* High-priority masters continuously generate traffic.
* Lower-priority masters issue requests simultaneously.

### Expected Result

* Fairness mode activates.
* Dominant master is temporarily blocked.
* Waiting masters complete transactions.
* No starvation occurs.

---

## 2. Matrix Congestion

### Objective

Validate non-blocking fabric behavior.

### Procedure

All masters communicate with all slaves simultaneously.

### Expected Result

* No deadlocks
* Correct routing
* No data corruption
* Sustained throughput

---

## 3. Slave Backpressure

### Objective

Validate pipeline stall propagation.

### Procedure

Slave response latency is artificially increased (up to 6 cycles).

### Expected Result

* READY signals deassert correctly
* Backpressure propagates upstream
* No protocol violations occur

---

## 4. Write Timeout Validation

### Procedure

* Slave intentionally suppresses BVALID.
* Timeout counter expires.

### Expected Result

```text
BRESP = DECERR
```

generated automatically.

---

## 5. Read Timeout Validation

### Procedure

* Slave intentionally suppresses RVALID.
* Timeout counter expires.

### Expected Result

```text
RRESP = SLVERR
RLAST = 1
```

generated automatically.

---

## 6. Error Monitoring Validation

### Procedure

Inject:

```text
SLVERR
DECERR
```

responses.

### Expected Result

* Error counters increment
* Error flags assert
* Monitor correctly records failures

---

# Waveform Analysis

## Test Case 1 – Starvation & Priority Arbitration

### Observation

Multiple masters issue concurrent write requests.

### Result

The arbiter serializes requests correctly and routes transactions to the appropriate slaves, demonstrating proper arbitration and fairness enforcement.

---

## Test Case 2 – Matrix Congestion

### Observation

Heavy traffic activity is observed across the write data channels.

### Result

The crossbar sustains simultaneous master-to-slave communications without fabric-wide stalls, demonstrating non-blocking behavior and data integrity.

---

## Test Case 3 – Extreme Backpressure

### Observation

Delayed slave responses cause repeated B-channel wait conditions.

### Result

Backpressure propagates correctly through the fabric and prevents masters from overwhelming busy slaves.

---

# Verification Results

## Stability

* Stable operation at 100% bandwidth saturation
* No protocol violations observed

## Performance

* Successful completion of 16-beat bursts
* Correct operation under highly asymmetric pipeline delays

## Reliability

* Deadlock-free operation
* Correct timeout recovery
* Accurate error reporting
* Robust arbitration under heavy contention

---

# Feature Comparison

| Feature                        | Original Crossbar | Enhanced Crossbar |
| ------------------------------ | ----------------- | ----------------- |
| Round-Robin Arbitration        | ✓                 | ✓                 |
| Static Priority Support        | ✓                 | ✓                 |
| Adaptive Fairness Arbitration  | ✗                 | ✓                 |
| Request Monitoring             | ✗                 | ✓                 |
| Response Error Monitoring      | ✗                 | ✓                 |
| Write Timeout Recovery         | ✗                 | ✓                 |
| Read Timeout Recovery          | ✗                 | ✓                 |
| Runtime Statistics             | ✗                 | ✓                 |
| Enhanced Starvation Protection | Limited           | ✓                 |
| Verification Framework         | Basic             | Comprehensive     |

---

# Impact

The enhanced AXI4 Crossbar evolves beyond a simple routing fabric into a monitored, fault-aware, fairness-enhanced interconnect suitable for modern SoC environments.

Key improvements include:

* Adaptive fairness arbitration
* Runtime traffic analytics
* Transaction error monitoring
* Read/write timeout recovery
* Improved reliability
* Better debug visibility
* Comprehensive verification coverage

These enhancements ensure reliable operation under contention, congestion, and fault conditions while maintaining protocol compliance and high throughput.
