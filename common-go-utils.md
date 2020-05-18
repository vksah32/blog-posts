# Common Go stuff

### 1. Write `{key, value}` data to json file



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



### 2. Send slack message to a channel

- create an app in slack

- Find the webhook url

- Call this function

  ```go
  func SendSlackNotification(webhookUrl string, msg string) error {
  
  	slackBody, _ := json.Marshal(SlackRequestBody{Text: msg, Type: "mrkdwn"})
  	req, err := http.NewRequest(http.MethodPost, webhookUrl, bytes.NewBuffer(slackBody))
  	if err != nil {
  		return err
  	}
  
  	req.Header.Add("Content-Type", "application/json")
  
  	client := &http.Client{Timeout: 10 * time.Second}
  	resp, err := client.Do(req)
  	if err != nil {
  		return err
  	}
  
  	buf := new(bytes.Buffer)
  	buf.ReadFrom(resp.Body)
  	if buf.String() != "ok" {
  		return errors.New("Non-ok response returned from Slack")
  	}
  	return nil
  }
  
  ```

  

  

