# Common Go stuff

## Write `{key, value}` data to json file



```go
// declare keyvalue struct
type KeyValue struct {
	Key   string
	Value string
}
```



To write

```go
enc := json.NewEncoder(file)
  for _, kv := ... {
    err := enc.Encode(&kv)
```



  To read it back

```go
dec := json.NewDecoder(file)
  for {
    var kv KeyValue
    if err := dec.Decode(&kv); err != nil {
      break
    }
    kva = append(kva, kv)
  }


```

