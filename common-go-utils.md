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

### 2. Parse Time

```go

func main() {
  now := time.Now()
  
	startTime := "2020-05-06 09:30"
	t,_ := time.Parse("2006-01-02 15:04", startTime)
  
	secs := now.Unix()
	nanos := now.UnixNano()
  millis := nanos / 1000000
}


// Parse from strign timestamp to a go time object

func parseTs(ts string) time.Time {
		i, err := strconv.ParseInt(ts, 10, 64)
    if err != nil {
        panic(err)
    }
    return time.Unix(i, 0)
    
}
```

### 3. Call a http endpoint and parse JSON response

```go

// don't have to specify all fields, only ones useful
// use https://mholt.github.io/json-to-go/ to automatically generate go structs
type apiResponse struct {
	FieldA       string     `json:"fieldA"`
	FieldB       fieldBStruct `json:"fieldB"`
}

type fieldBStruct {
	FieldA   string   `json:"fieldC"`
}

func callEndpoint() apiResponse {
	endpointURL := "http://somesite.com/endpoint"
	resp, err := http.Get(endpointURL)
	if err != nil {
		log.Panicln(err)
	}
	defer resp.Body.Close()
	body, readErr := ioutil.ReadAll(resp.Body)
	// log.Println(string(body))
	if readErr != nil {
		log.Fatal(readErr)
	}
	response := apiResponse{}
	err = json.Unmarshal(body, &response)
	if err != nil {
		log.Panicln(err)
	}
	return response
}


```

### 4. Send slack message to a channel

- create an app in slack

- Allow incoming Webhooks

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

  

  

