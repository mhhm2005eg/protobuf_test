protobuf_repo=/home/medhat/Data/repository/protobuf

PROTOC=${protobuf_repo}/cmake/build/protoc

$PROTOC  --cpp_out=./generated ./matrix.proto


