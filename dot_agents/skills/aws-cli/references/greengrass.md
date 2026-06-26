# AWS IoT Greengrass V2 CLI Reference

## Overview
AWS IoT Greengrass brings local compute, messaging, data management, sync, and ML inference to edge devices. Version 2 provides new APIs and console for managing components, deployments, and core devices.

**Key capabilities:**
- Local compute, messaging, and data management on edge devices
- ML inference at the edge
- Autonomous local event processing
- Secure local networking between devices
- Secure communication with AWS IoT Core
- Deploy Lambda functions and components to device fleets

## Available Commands

### Deployment Management
- `cancel-deployment` - Cancel an active deployment
- `create-deployment` - Create a new deployment
- `get-deployment` - Retrieve deployment details
- `list-deployments` - List all deployments
- `list-effective-deployments` - List deployments currently applied to a device

### Component Management
- `create-component-version` - Create a new component version
- `describe-component` - Get component details
- `get-component` - Retrieve component metadata
- `get-component-version-artifact` - Download component version artifacts
- `list-components` - List all components
- `list-component-versions` - List versions of a component
- `resolve-component-candidates` - Resolve component candidates for deployment

### Core Device Management
- `get-core-device` - Get core device information
- `delete-core-device` - Delete a core device
- `list-core-devices` - List all core devices
- `list-installed-components` - List components installed on a device

### Tagging & Resources
- `tag-resource` - Add tags to a resource
- `untag-resource` - Remove tags from a resource
- `list-tags-for-resource` - List tags on a resource

## References
- [AWS IoT Greengrass Developer Guide](https://docs.aws.amazon.com/greengrass/v2/developerguide/what-is-iot-greengrass.html)
- AWS CLI v2.1.29 Reference
