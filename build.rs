use std::env;
use std::process::{Command, Stdio};

#[allow(unused_must_use)]
fn main() {
  if env::var("STDIO_NULL").is_ok() {
    Command::new("cat").stdin(Stdio::null()).spawn();
  } else {
    Command::new("cat").spawn();
  }
}
