# Protobuf Cheatsheet

Protocol Buffers compiler (`protoc`) and `.proto` file syntax reference.

---

## protoc Basic Usage

```bash
protoc --proto_path=IMPORT_DIR --cpp_out=OUT_DIR file.proto
protoc -I=IMPORT_DIR --python_out=OUT_DIR file.proto
```

The `--proto_path` (or `-I`) flag specifies where to search for imported `.proto` files. If omitted, the current directory is used.

## Output Flags

Each output flag generates code for a specific language:

| Flag | Language |
|------|----------|
| `--cpp_out=DIR` | C++ |
| `--java_out=DIR` | Java |
| `--python_out=DIR` | Python |
| `--go_out=DIR` | Go (requires protoc-gen-go) |
| `--rust_out=DIR` | Rust (requires protoc-gen-rust) |
| `--js_out=DIR` | JavaScript |
| `--csharp_out=DIR` | C# |
| `--ruby_out=DIR` | Ruby |
| `--objc_out=DIR` | Objective-C |
| `--php_out=DIR` | PHP |
| `--dart_out=DIR` | Dart |
| `--kotlin_out=DIR` | Kotlin |
| `--swift_out=DIR` | Swift (requires plugin) |

Multiple output flags can be used in a single invocation:

```bash
protoc -I=proto --cpp_out=gen/cpp --python_out=gen/python proto/service.proto
```

## Plugins

```bash
protoc --plugin=protoc-gen-NAME=PATH --NAME_out=DIR file.proto
```

### Common Plugins

| Plugin | Flag | Description |
|--------|------|-------------|
| `protoc-gen-go` | `--go_out` | Go code generation |
| `protoc-gen-go-grpc` | `--go-grpc_out` | Go gRPC stubs |
| `protoc-gen-grpc-java` | `--grpc-java_out` | Java gRPC stubs |
| `protoc-gen-grpc-web` | `--grpc-web_out` | gRPC-Web stubs |
| `protoc-gen-doc` | `--doc_out` | Documentation |
| `protoc-gen-validate` | `--validate_out` | Validation rules |
| `protoc-gen-grpc-python` | `--grpc_python_out` | Python gRPC stubs |

### gRPC Example

```bash
# Go
protoc -I=proto \
  --go_out=gen --go_opt=paths=source_relative \
  --go-grpc_out=gen --go-grpc_opt=paths=source_relative \
  proto/service.proto

# Python
python -m grpc_tools.protoc -I=proto \
  --python_out=gen --grpc_python_out=gen \
  proto/service.proto

# C++
protoc -I=proto \
  --cpp_out=gen --grpc_out=gen --plugin=protoc-gen-grpc=$(which grpc_cpp_plugin) \
  proto/service.proto
```

## Useful protoc Flags

| Flag | Description |
|------|-------------|
| `-I PATH` / `--proto_path=PATH` | Import search path (repeatable) |
| `--descriptor_set_out=FILE` | Write a FileDescriptorSet binary |
| `--include_imports` | Include imported files in descriptor set |
| `--include_source_info` | Include source info in descriptor set |
| `--dependency_out=FILE` | Write dependency info (Makefile format) |
| `--decode=MSG_TYPE` | Decode binary proto from stdin |
| `--decode_raw` | Decode binary proto without schema |
| `--encode=MSG_TYPE` | Encode text format to binary from stdin |
| `--error_format=FORMAT` | Error format: `gcc` or `msvs` |
| `--fatal_warnings` | Treat warnings as errors |

### Decode / Encode

```bash
# Decode a binary protobuf message
cat message.bin | protoc --decode=mypackage.MyMessage -I=proto proto/msg.proto

# Decode without a schema
cat message.bin | protoc --decode_raw

# Encode text format to binary
cat message.txt | protoc --encode=mypackage.MyMessage -I=proto proto/msg.proto > message.bin
```

---

## .proto Syntax (proto3)

### File Structure

```protobuf
syntax = "proto3";

package mypackage;

option go_package = "github.com/user/repo/pb";
option java_package = "com.example.mypackage";
option java_multiple_files = true;

import "google/protobuf/timestamp.proto";
import "other.proto";
```

### Messages

```protobuf
message Person {
  string name = 1;
  int32 age = 2;
  string email = 3;

  // Nested message
  message Address {
    string street = 1;
    string city = 2;
  }

  Address address = 4;
  repeated string phone_numbers = 5;   // list
  map<string, string> metadata = 6;    // map
  optional string nickname = 7;        // explicit optional
}
```

### Scalar Types

| Proto Type | C++ | Python | Go | Rust |
|-----------|-----|--------|-----|------|
| `double` | `double` | `float` | `float64` | `f64` |
| `float` | `float` | `float` | `float32` | `f32` |
| `int32` | `int32_t` | `int` | `int32` | `i32` |
| `int64` | `int64_t` | `int` | `int64` | `i64` |
| `uint32` | `uint32_t` | `int` | `uint32` | `u32` |
| `uint64` | `uint64_t` | `int` | `uint64` | `u64` |
| `sint32` | `int32_t` | `int` | `int32` | `i32` |
| `sint64` | `int64_t` | `int` | `int64` | `i64` |
| `fixed32` | `uint32_t` | `int` | `uint32` | `u32` |
| `fixed64` | `uint64_t` | `int` | `uint64` | `u64` |
| `bool` | `bool` | `bool` | `bool` | `bool` |
| `string` | `string` | `str` | `string` | `String` |
| `bytes` | `string` | `bytes` | `[]byte` | `Vec<u8>` |

Use `sint32`/`sint64` for frequently negative values (more efficient encoding). Use `fixed32`/`fixed64` when values are often large.

### Enums

```protobuf
enum Status {
  STATUS_UNSPECIFIED = 0;   // must have a zero value
  STATUS_ACTIVE = 1;
  STATUS_INACTIVE = 2;
}
```

### Oneof

```protobuf
message Result {
  oneof result {
    string error = 1;
    int32 value = 2;
  }
}
```

### Services (gRPC)

```protobuf
service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply);
  rpc ServerStream (Request) returns (stream Response);       // server streaming
  rpc ClientStream (stream Request) returns (Response);       // client streaming
  rpc BidiStream (stream Request) returns (stream Response);  // bidirectional
}
```

### Well-Known Types

```protobuf
import "google/protobuf/timestamp.proto";
import "google/protobuf/duration.proto";
import "google/protobuf/empty.proto";
import "google/protobuf/any.proto";
import "google/protobuf/wrappers.proto";
import "google/protobuf/struct.proto";

message Example {
  google.protobuf.Timestamp created_at = 1;
  google.protobuf.Duration timeout = 2;
  google.protobuf.Any payload = 3;
  google.protobuf.StringValue nullable_name = 4;  // wrapper for nullable
  google.protobuf.Struct config = 5;               // JSON-like structure
}
```

### Field Number Rules

- Must be unique within a message
- Range 1-15: single byte encoding (use for frequent fields)
- Range 16-2047: two byte encoding
- Range 1-536,870,911: valid range
- 19000-19999: reserved (protobuf implementation)

### Reserved Fields

```protobuf
message Foo {
  reserved 2, 15, 9 to 11;
  reserved "old_field", "removed_field";
}
```

### Options

```protobuf
option optimize_for = SPEED;       // SPEED, CODE_SIZE, LITE_RUNTIME

message Msg {
  string name = 1 [deprecated = true];
  repeated int32 values = 2 [packed = true];
  string id = 3 [json_name = "ID"];
}
```

## Buf (modern protobuf tooling)

```bash
buf lint                     # lint proto files
buf format -w                # format proto files
buf generate                 # generate code (replaces protoc)
buf build                    # build/validate proto files
buf breaking --against .git#branch=main  # breaking change detection
```
