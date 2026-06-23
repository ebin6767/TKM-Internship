<img width="1245" height="591" alt="17822016270907423676128194679377" src="https://github.com/user-attachments/assets/fabaa73c-95a1-4d10-bc61-b73cf43d269b" />

<img width="1249" height="584" alt="17822016525844981838456674480048" src="https://github.com/user-attachments/assets/eceb5ee7-e39b-4e2c-bfc4-58310e73e481" />

<img width="1252" height="585" alt="17822017159361643659355073521763" src="https://github.com/user-attachments/assets/00fe1902-e887-4751-9cff-5004370c7448" />

<img width="1242" height="196" alt="17822017397071270313203927260378" src="https://github.com/user-attachments/assets/d161edb8-9435-49b7-89b6-3cec072f71b8" />


<img width="863" height="425" alt="17822017678416675071756341636953" src="https://github.com/user-attachments/assets/27a06db1-9dd6-44e9-8ad2-4cc5f00697db" />

# AXI4 Crossbar with Adaptive Fairness Arbitration and Reliability Enhancements

# Project Overview

This project extends an open-source AXI4/AXI4-Lite Crossbar Interconnect by introducing adaptive arbitration, runtime monitoring, response error tracking, and transaction timeout handling. In addition to the design enhancements, a comprehensive verification framework was developed to validate functionality, protocol compliance, fairness, reliability, and performance under heavy traffic conditions.

The original crossbar provides configurable M×N AXI interconnect functionality with round-robin arbitration, buffering, clock-domain crossing support, and memory-map based routing. Our work enhances the design with fault-awareness, runtime observability, and improved fairness between competing masters.

# Original Crossbar Features

Configurable M×N master/slave interfaces
AXI4 and AXI4-Lite support
Master/slave buffering capability
Configurable outstanding transaction depth
Clock Domain Crossing (CDC) support
Round-robin arbitration
Configurable priority levels
Memory-map based routing
Access restriction through routing tables
USER signal support on all AXI channels

# Architecture
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

# Design Enhancements

The following modules were developed and integrated into the crossbar architecture:

axicb_req_logger.sv
axicb_resp_monitor.sv
axicb_fairness_arbiter.sv

These additions improve:

- Fairness among competing masters
- Runtime traffic visibility
- Error det- ction and monitoring
- Fault recovery thr- ugh timeouts
- Debugging and performance analysis

# 1. Request Logger (axicb_req_logger.sv)

# Motivation

The original design lacked visibility into traffic patterns and request distribution among masters.

# Implementation

The logger passively monitors:

AWVALID && AWREADY
ARVALID && ARREADY

for each master interface.

Whenever a successful address handshake occurs, the corresponding request counter is incremented.

# Outputs

req_count[i]

A monitoring window may be reset using:

window_clear

# Benefits

- Traffic profilin- 
- Runtime statistics collection
- Arbitration analysis
- Performance debugging

