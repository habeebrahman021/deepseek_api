# Issue: Dio instance is not passed to DeepSeekAPI constructor

It appears the code snippet initializes a custom Dio instance with a LogInterceptor, but the customDio is not passed to the DeepSeekAPI constructor. As a result, the custom interceptor and any Dio configurations will not be used by DeepSeekAPI.

## Expected behavior:
The constructor for DeepSeekAPI should accept a Dio instance, or there should be a way to inject a custom Dio configuration.

## Suggested solution:
Allow passing a custom Dio instance to DeepSeekAPI, e.g. `final deepseek = DeepSeekAPI(apiKey: 'your-key', baseUrl: 'https://api.deepseek.com/v2', dio: customDio);`