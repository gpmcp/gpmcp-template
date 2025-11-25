#[async_trait::async_trait]
pub trait API: Send + Sync + 'static {}
