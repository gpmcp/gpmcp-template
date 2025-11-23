use project_services::{ExampleService, ExampleServiceImpl};

#[tokio::test]
async fn test_example_service() {
    let service = ExampleServiceImpl::new();
    let result = service.do_something().await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap(), "Hello from service");
}
