---
name: aws-cloudwatch
description: Use for analyzing aws logs.
---

# AWS CloudWatch CLI Reference

## Overview
Amazon CloudWatch monitors your Amazon Web Services (AWS) resources and the applications you run on AWS in real time. You can use CloudWatch to collect and track metrics, which are the variables you want to measure for your resources and applications.

**Key capabilities:**
- Monitor metrics from AWS resources and custom applications
- Create and manage CloudWatch alarms for automated responses
- Create dashboards to visualize metrics and trends
- Track application performance and operational health
- Store and analyze log data through CloudWatch Logs
- Detect anomalies in metrics automatically
- Generate insights from metric patterns and trends

## Available Commands

### Metric Management
- `put-metric-data` - Put custom metric data points into CloudWatch
- `get-metric-statistics` - Get statistics for a specified metric
- `get-metric-data` - Get multiple metric data points in a single request
- `list-metrics` - List all available metrics
- `describe-alarms-for-metric` - Get alarms for a specific metric

### Alarm Management
- `put-metric-alarm` - Create or update a metric alarm
- `put-composite-alarm` - Create or update a composite alarm
- `describe-alarms` - Describe all CloudWatch alarms
- `describe-alarm-history` - Get alarm history
- `disable-alarm-actions` - Disable alarm actions
- `enable-alarm-actions` - Enable alarm actions
- `set-alarm-state` - Set the state of an alarm

### Alarm Mute Rules
- `put-alarm-mute-rule` - Create or update an alarm mute rule
- `get-alarm-mute-rule` - Get a specific mute rule
- `list-alarm-mute-rules` - List all mute rules

### Dashboard Management
- `get-dashboard` - Get dashboard details
- `list-dashboards` - List all dashboards
- `get-metric-widget-image` - Get an image of a metric widget

### Anomaly Detection
- `put-anomaly-detector` - Create or update an anomaly detector
- `describe-anomaly-detectors` - Describe all anomaly detectors

### Insight Rules
- `put-insight-rule` - Create or update an insight rule
- `put-managed-insight-rules` - Create or update managed insight rules
- `describe-insight-rules` - Describe all insight rules
- `get-insight-rule-report` - Get the report for an insight rule
- `enable-insight-rules` - Enable insight rules
- `disable-insight-rules` - Disable insight rules
- `list-managed-insight-rules` - List managed insight rules

### Metric Streams
- `put-metric-stream` - Create or update a metric stream
- `get-metric-stream` - Get metric stream details
- `list-metric-streams` - List all metric streams

### Tagging & Resources
- `list-tags-for-resource` - List tags on a CloudWatch resource
- `tag-resource` - Add tags to a CloudWatch resource
- `untag-resource` - Remove tags from a CloudWatch resource
- `describe-alarm-contributors` - Get the alarm contributors

