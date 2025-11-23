use thiserror::Error;

#[derive(Error, Debug)]
pub enum DomainError {}

pub type DomainResult<T> = Result<T, DomainError>;
