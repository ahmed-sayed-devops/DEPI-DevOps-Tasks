# Prometheus & Node Exporter Lab

This lab demonstrates the installation and configuration of Prometheus and Node Exporter, followed by practical examples of PromQL queries using real metrics collected from the machine.

---

## 📌 Lab Objectives

- Install and configure Prometheus.
- Install and configure Node Exporter.
- Connect Prometheus to Node Exporter and scrape system metrics.
- Verify Prometheus targets.
- Practice PromQL using:
  - Scalar
  - Instant Vector
  - Range Vector
  - rate()
  - irate()

---

# 1. Prometheus Targets

After configuring Prometheus and Node Exporter, both targets were successfully discovered and are in the UP state.

![Prometheus Targets](../Prometheus_tasks/screenshots/01-prometheus%20targets.png)

---

# 2. Prometheus Metrics

Prometheus collects metrics from Node Exporter through the `/metrics` endpoint.

![Prometheus Metrics](../Prometheus_tasks/screenshots/02-prometheus%20metrics.png)

---

# 3. PromQL

## A. Scalar

A Scalar is a single numerical value without labels or multiple time series.

### Example 1: Number of CPUs

```promql
count(count(node_cpu_seconds_total) by (cpu))
```

This query returns the number of CPU cores available on the machine.

![Scalar Example 1](../Prometheus_tasks/screenshots/03-scaler%20ex1%20-%20num%20of%20cpus.png)

---

### Example 2: Number of Targets

```promql
count(up)
```

This query counts the available Prometheus targets.

![Scalar Example 2](../Prometheus_tasks/screenshots/04-scaler%20ex2%20-%20num%20of%20targets.png)

---

### Example 3: Number of Network Interfaces

```promql
count(node_network_receive_bytes_total)
```

This query counts the network interfaces exporting receive traffic metrics.

![Scalar Example 3](../Prometheus_tasks/screenshots/05-scaler%20ex3%20-%20num%20of%20net%20interfaces.png)

---

## B. Instant Vector

An Instant Vector contains a set of time series with a single sample for each series at the current evaluation time.

### Example 1: CPU Metrics

```promql
node_cpu_seconds_total
```

Displays CPU time metrics for different CPUs and modes.

![Instant Vector CPU](../Prometheus_tasks/screenshots/06-instanst%20verctor%20ex1%20-%20cpu%20metrics.png)

---

### Example 2: Available Memory

```promql
node_memory_MemAvailable_bytes
```

Displays the currently available memory in bytes.

![Instant Vector Memory](../Prometheus_tasks/screenshots/07-instanst%20verctor%20ex2%20-%20available%20memory.png)

---

### Example 3: Available Disk Space

```promql
node_filesystem_avail_bytes
```

Displays the available disk space for the mounted filesystems.

![Instant Vector Disk](../Prometheus_tasks/screenshots/08-instanst%20verctor%20ex3%20-%20disk%20space.png)

---

## C. Range Vector

A Range Vector returns multiple samples for each time series over a specified time range.

### Example 1: CPU Metrics in the Last 5 Minutes

```promql
node_cpu_seconds_total[5m]
```

Returns CPU metric samples collected during the last 5 minutes.

![Range Vector CPU](../Prometheus_tasks/screenshots/09-range%20vector%20ex1%20-%20cpu%20in%205%20min.png)

---

### Example 2: Available Memory in the Last 10 Minutes

```promql
node_memory_MemAvailable_bytes[10m]
```

Returns memory samples collected during the last 10 minutes.

![Range Vector Memory](../Prometheus_tasks/screenshots/10-range%20vector%20ex2%20-%20mem%20in%2010%20min.png)

---

### Example 3: Network Received Bytes in the Last 5 Minutes

```promql
node_network_receive_bytes_total[5m]
```

Returns network receive traffic samples from the last 5 minutes.

![Range Vector Network](../Prometheus_tasks/screenshots/11-range%20vector%20ex3%20-%20net%20received%20byets%20in%205%20min.png)

---

# 4. rate() and irate()

Both `rate()` and `irate()` are mainly used with counter metrics.

- `rate()` calculates the average per-second rate over a time range.
- `irate()` calculates the per-second rate based on the latest two samples and reacts faster to recent changes.

---

## rate() Example: Network Traffic

```promql
rate(node_network_receive_bytes_total{device="eth0"}[5m])
```

Calculates the average network receive rate per second during the last 5 minutes.

![Rate Network Traffic](../Prometheus_tasks/screenshots/12-%20rate%20ex1%20net%20traffic.png)
---

## irate() Example: Network Traffic

```promql
irate(node_network_receive_bytes_total{device="eth0"}[5m])
```

Calculates the instant network receive rate based on the latest samples.

![IRate Network Traffic](../Prometheus_tasks/screenshots/13-%20irate%20ex1%20net%20traffic.png)

---

## rate() Example: CPU Usage

```promql
100 - (
  avg by(instance) (
    rate(node_cpu_seconds_total{mode="idle"}[5m])
  ) * 100
)
```

Calculates the average CPU usage percentage over the last 5 minutes.

![Rate CPU Usage](../Prometheus_tasks/screenshots/14-%20rate%20ex2%20-%20cpu%20usage.png)

---

## irate() Example: CPU Usage

```promql
100 - (
  avg by(instance) (
    irate(node_cpu_seconds_total{mode="idle"}[5m])
  ) * 100
)
```

Calculates CPU usage percentage using the most recent samples.

![IRate CPU Usage](../Prometheus_tasks/screenshots/15-%20irate%20ex2%20-%20cpu%20usage.png)

---

# Conclusion

In this lab, Prometheus and Node Exporter were successfully installed and configured. Prometheus was able to scrape system metrics from Node Exporter, and multiple practical PromQL queries were executed using real system metrics.

The lab covered:

- Scalar
- Instant Vector
- Range Vector
- rate()
- irate()

These queries provide useful insights into CPU, memory, disk, and network usage.