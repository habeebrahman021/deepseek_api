## Issue: Allow Custom Dio Instance in DeepSeekAPI Constructor

### Description
There is a need to allow passing a custom Dio instance to the `DeepSeekAPI` constructor. The current implementation does not utilize the `customDio`, which prevents users from applying their own custom interceptors and configurations.

### Expected Behavior
- `DeepSeekAPI` should accept a `Dio` instance or provide a way to inject custom `Dio` configuration.

### Steps to Reproduce
1. Create a custom `Dio` instance with specific interceptors and configurations.
2. Pass this instance to the `DeepSeekAPI` constructor.
3. Observe that the custom interceptors and configurations are not applied.

### Suggested Solution
Modify the constructor of `DeepSeekAPI` to accept an optional `Dio` instance. If provided, use this instance instead of the default one.