# **Summary**
This document outlines the integration specification for the WebSocket API integration between CargoWise One (CW1) and BorderWise, specifically focusing on the WebSocket Hub component. 

# **What is the WebSocket API and why do we need it for BorderWise and CargoWiseOne integration?**
The WebSocket API allows real-time communication between two systems using WebSocket technology. It allows us to send messages to a WebSocket hub and receive event-driven responses without having to poll the WebSocket hub for a reply. In our scenario, it allows for real-time communication between BorderWise and CargowiseOne. 

# **A high level overview of BorderWise and CargoWiseOne integration using the WebSocket API**

1. When we open BorderWiseWeb from CargoWiseOne, we end up with a BorderWise Web URL with various query parameters. For example,
	
    [https://app.borderwise.com/?**tariff**=0203.11.00**stat**=07&impexp=I&c=AU&ret=edient:Command%3DShowEditForm%26LicenceCode%3DEDIEDIDAT%26ControllerID%3DBorderWiseWebReturnHook%26BusinessEntityPK%3D7edaf780-a807-4319-928a-b21cf7ad69b9%26Hash%3D%2bCTL0nUJ841AN0c6JHjyqdKbl2GezTpZz%26Args%3D&version=2&**mode**=Batch&WebSocketClientId=7edaf780-a807-4319-928a-b21cf7ad69b9&WebSocketTimestamp=20230531102831]()
    
    This link will open up to a tariff table (as per **tariff** param provided in url) for the respective country (**country** param), with a specific status code highlighted (**stat** param). Further, when we open BorderWise with this URL, we either end up in Single-Line Tariff Classification mode or Multi-Line Tariff Classification mode based on url parameter **mode**. This URL also includes a **WebSocketClientId**, a unique client ID that BWW will use to establish a connection with the WebSocket Hub, and ensure that all messages sent to the hub by BWW can be forwarded on to the correct CW1 instance. Read more about the [BorderWise URL parameters here](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=**borderwise-url-parameters**).
1. When the BWW app is opened in the step above, we are [initializing the web socket connection](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=initiate-websocket-connection).
1.  After successfully initializing the WebSocket connection with the BorderWise WebSocket hub, the WebSocket's onOpen event handler is triggered and BWW proceeds to send [an initial message](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=when-websocket-connection-is-successfully-established) to the BorderWise WebSocket Hub, indicating the start (STA) of web socket exchange. All these messages exchanged over the WebSocket channel have a [specific format](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=**exchange-message-format**).
The Message flow varies according to the **mode** of tariff classification:

    - For Single-line Tariff Classification
      1. After specifying the Tariff Code for the single invoice line, BorderWise will send a response message (MSG) with the tariff code to BorderWise WebSocket Hub. This gets passed on to CW1.
      1. CW1 sends message (FIN) indicating the completion of WebSocket exchange.  This message is relayed to BWW and the WebSocket connection is closed as a result. 

    - For Multi-line Tariff Classification
      1. Proceeding this, BWW sends a [message (MSG)](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=on-receiving-a-message-from-websocket-hub) to the BorderWise WebSocket Hub indicating that the WebSocket is connected, and this is then relayed to CW1. 
      1. Now that the WebSocket connection has been established, CW1 can send a message to the WebSocket Hub with the **invoice lines**. WebSocket Hub then pushes these invoice lines to BWW.
      1. After classifying the invoice lines, BorderWise will send a response message (MSG) with the **tariff classification** to BorderWise WebSocket Hub. This gets passed on to CW1. 
      1. CW1 sends message (FIN) indicating the completion of WebSocket exchange.  This message is relayed to BWW and the WebSocket connection is closed as a result. 

1. Outside of this chain of events, we can also have error (ERR) and cancellation (CAN) messages. Read more about these [here](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/5945/CW1-BorderWise-integration-specification?anchor=**exchange-message-format**).  

# **Message Flow Diagram**

The below diagram depicts flow of messages between: 
- CargoWise One (CW1) 
- BorderWise Portal (BW Web) 
- BorderWise WebSocket Hub (BWW.API)

![download.png](/.attachments/download-5c3548e5-629b-427f-8188-1e9d14dd9319.png)

   **Note**: If the BorderWise web application fails to send a WebSocket message to CW1 due to WebSocket connection failure, 
   it will fallback to using EdiCommand to send the message. 

# **BorderWise WebSocket Hub API**

- ### Description 
  This API endpoint handles WebSocket requests and establishes a WebSocket connection with the client. It listens for incoming WebSocket connections and processes messages sent by the client. 

- ### Route 
  GET https://app.borderwise.com/api/ws/hub 

- ### Request Headers 
  No specific request headers are required for this API. 

- ### Request Parameters 
  No request parameters are used in this API. 

- ### Response 
  The API establishes a WebSocket connection with the client if the request is a valid WebSocket upgrade request. If the WebSocket connection is successfully established, it proceeds to process the upcoming web socket messages. 

- ### Errors 
  If the request is not a valid WebSocket request, the API responds with a BadRequest status code (HTTP 400). If the WebSocket connection is closed with an error, the API logs the error and sets the response status code to BadRequest (HTTP 400). 

- ### Authentication 
  This API does not require any authentication. Clients are supposed to use unique identifiers (GUID) for message exchange which guarantees that fraudulent client is not able to send fake messages to real users unless they know the identifier 

- ### More details 
  Refer to the article [CargowiseOne and Borderwise Integration](https://wisetechglobal.sharepoint.com/sites/StackOverflow/Articles/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2FArticles%2F10505%2Emd&parent=%2Fsites%2FStackOverflow%2FArticles) for an overview of BorderWise WebSocket Hub Architecture.


# **BorderWise URL Parameters** 
When CW1 initiates the opening of BorderWise, certain URL parameters are included as part of the URL. These parameters determine the behavior of the BorderWise. Below are the details of each parameter passed in the URL: 

- **tariff**: This parameter specifies the tariff code to be searched for once BorderWise is opened. After loading BorderWise, it will display the tariff table containing this specific tariff code. 

- **stat**: This parameter indicates the stat code to be highlighted upon opening BorderWise. After loading BorderWise, it will highlight the specified stat code in the tariff table. 

- **impexp**: This parameter determines the type of tariff classification and can take two possible values: 
  - "I": Indicates Import classification. 
  - "E": Indicates Export classification. 

- **country**: This parameter identifies the country code of tariff classification. Currently supported country codes by BorderWise are 
  - AU: Australia 
  - CA: Canada 
  - EU: European Union 
  - NZ: New Zealand 
  - SG: Singapore 
  - ZA: South Africa 
  - UK: United Kingdom 
  - US: United States 

- **ret**: This parameter contains the edient command that should be used to return tariff data back to CW1 in case the WebSocket connection fails.  

- **version**: This parameter determines the version of the Exchange Message Model between CW1 and BorderWise. Currently supported values for this parameter are 

  - 1 : This model supports only one tariff classification at a time, and this will be outdated in some time. 
  - 2 : This model supports multi-line tariff classification in one go. 

- **mode**: This parameter determines the mode of tariff classification and can have the following possible values: 

  - SINGLE : Indicates single-line tariff classification, meaning only one invoice line can be classified from the current instance of BorderWise. 
   - BATCH : Indicates multi-line tariff classification, allowing multiple invoice lines to be classified from the current instance of BorderWise. 

The value of this parameter is determined by BW API based on user details and country of tariff classification.

- **WebSocketClientId**: This parameter represents a unique client ID used by BorderWise to establish a connection with the WebSocket Hub. 

- **WebSocketTimestamp**: This parameter specifies the current timestamp in the format yyyyMMddHHmmss . 
 
  Example of BorderWise URL opened from CW1  

 
  https://app.borderwise.com/?tariff=0203.11.00&stat=07&impexp=I&c=AU&ret=edient:Command%3DShowEditForm%26LicenceCode%3DEDIEDIDAT%26ControllerID%3DBorderWiseWebReturnHook%26BusinessEntityPK%3D7edaf780-a807-4319-928a-b21cf7ad69b9%26Hash%3D%252bCTL0nUJ841AN0c6JHjyqdKbl2GezTpZz%26Args%3D&version=2&mode=Batch&WebSocketClientId=7edaf780-a807-4319-928a-b21cf7ad69b9&WebSocketTimestamp=20230531102831 

 

# **Exchange Message Format**

The messages exchanged over WebSocket channel have to follow a specific format and the [WebSocketExchangeMessage](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FBackend%2FWebApi%2FCore%2FModels%2FWebSocketExchangeMessage.cs&_a=contents&version=GBmaster) class represents the data model for it. Below are the details of fields in the WebSocketExchangeMessage Model.

- **ClientId** (Guid): A unique identifier assigned to each WebSocket client. 

- **SystemNameSender** (string): A string representing the name of the system that sent the message. 

- **SystemNameRecipient** (string): A string representing the name of the system intended to receive the message. 

- **Status** ([WebSocketExchangeMessageStatus](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FBackend%2FWebApi%2FCore%2FHelpers%2FConstants.cs&version=GBmaster&_a=contents)): An enum representing the status of the WebSocket message. It has the following possible values. 

  - **STA** (Status - 1) stands for "START" and is used to start websocket message exchange. This should be the first message sent to WebSocket Hub after establishing the connection 

  - **MSG** (Message - 2) stands for "Message" and represents a regular message exchanged between the client and the server. 

  - **FIN** (Finish - 3) stands for "Finish" and indicates the end or completion of a WebSocket exchange or communication. 

  - **ACK** (Acknowledgment - 4) stands for "Acknowledgment" and is used to acknowledge the receipt or successful processing of a WebSocket message. 

  - **ERR** (Error - 5) stands for "Error" and is used to indicate that an error has occurred during the WebSocket communication. 	 
    **Usage:** When an error is encountered in the communication process, the server or client may send an ERR message to inform the other party about the issue.  

  - **CAN** (Cancellation - 6) stands for "Cancellation" and is used to signal the cancellation of a WebSocket exchange or action. 
    **Usage:** When a WebSocket exchange or task needs to be canceled before completion, the server or client may send a CAN message to notify the other party about the cancellation. This event is sent by CW1 once the user press the Cancel button on the modal window. 

- **Data** (string): A string containing the main content or payload of the WebSocket message. 

  The data has to follow some specific format when the type of message is not Information i.e. it is a TariffClassification/InvoiceLine msg. The format of the data attribute 
 depends on the Mode parameter in the url passed by CW1 
 
  When the Mode param in the URL is BATCH, it implies that the user does the tariff classification for all the invoice lines in one go, then data should follow the following format 

  ```
  {
     BorderWiseTariffSelectionResults: [ 
       {	 
            invoiceLinePK    : guid, 
            invoiceLineNumber: integer, 
            invoiceNumber    : string, 
            tariffCode       : string, 
            statCode         : string, 
            description      : string, 
        } 
     ]
  }
  ```

  And when Mode param in the URL is SINGLE, which implies that the user is classifying only one invoice line, then data should follow the below format 

  `{
      TariffCode: string
  }`

- **Type** (string): A string representing the type or category of the message. It has the following possible value. 
  ###Information (Information): 
  Represents that the message transferred is an information message and not an actual InvoiceLines/TariffClassification msg. 

- **MachineName** (string): A string representing the name of the machine where the message originated from. 

- **Email** (string): A string representing an email associated with the WebSocket message (e.g., the sender's email). 

- **Timestamp** (DateTime): A DateTime property representing the timestamp of when the message was created. It is initialized with the current UTC time.  

## **Sample WebSocket Exchange Messages**
- ### Message with Status MSG 


  ```
  {  
      ClientId: 6d674c0c-5403-4039-af8d-5c8dc6bfddfe, 
      SystemNameSender: "CargoWiseOne ",  
      SystemNameRecipient: "BorderWiseWeb",  
      Status: MSG,  
      Data: { 
          BorderWiseTariffSelectionResults : [ 
              { 
                  Description: ".Weighing more than 1 kg but not more than 5 kg", 
                  InvoiceLineNumber: "1", 
                  InvoiceNumber: "123", 
                  IsSelected: false, 
                  StatCode: "", 
                  TariffCode: "2205.90.90 14" 
              } 
          ] 
      }, 
      Type: null,  
      MachineName: null,  
      Email: "testmail@ext",  
      Timestamp: 07/27/2023 09:37:29 
  }
    ```
 
- ### Cancel Message from CW1 


  ```
  {  
      ClientId: 6d674c0c-5403-4039-af8d-5c8dc6bfddfe, 
      SystemNameSender: "CargoWiseOne ",  
      SystemNameRecipient: "BorderWiseWeb",  
      Status: CAN,  
      Data: null, 
      Type: null,  
      MachineName: null,  
      Email: "testmail@ext",  
      Timestamp: 07/27/2023 09:37:29 
  }
  ```

# **BorderWise Portal WebSocket event handlers**

Source code URL: [BWW_ConnectToBWWWebSocketHub_SourceCode](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc%2Fapp%2Fcore%2Fservices%2Fwebsocket.service.js&_a=contents&version=GBmaster) 

- ### Initiate WebSocket Connection 

  Source code URL: [createWebSocketConnection](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc%2Fapp%2Fcore%2Fservices%2Fwebsocket.service.js&version=GBmaster&line=48&lineEnd=55&lineStartColumn=9&lineEndColumn=10&lineStyle=plain&_a=contents)  

  - When CW1 opens BorderWise window, the unique client ID is passed as a URL parameter with the name webSocketClientId. This client ID is used for further web socket message exchange. It ensures that all the messages sent to the Hub are redirected to the correct CW1 instance. 

  - BWW uses browser built-in WebSocket API to interact with WebSocket connections. 

  - To instantiate the WebSocket connection, the URL needed is [wss://app.borderwise.com/api/ws/hub]() in the case of BorderWise WebSocket Hub. 


- ### When WebSocket connection is successfully established  

  Source code URL: [startWebSocketMessageExchange](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc%2Fapp%2Fcore%2Fservices%2Fwebsocket.service.js&version=GBmaster&line=66&lineEnd=69&lineStartColumn=17&lineEndColumn=19&lineStyle=plain&_a=contents) 

  After successfully establishing the WebSocket connection with the BorderWise WebSocket hub, the WebSocket's onOpen event handler is triggered and the client proceeds to send an STA start message. 

  Sample STA start message 
 
  ```
  { 
      ClientId: 6d674c0c-5403-4039-af8d-5c8dc6bfddfe, 
      SystemNameSender: "BorderWiseWeb",  
      SystemNameRecipient: "BWW.API",  
      Status: STA,  
      Data: null,  
      Type: null,  
      MachineName: null,  
      Email: "testmail@ext",  
      Timestamp: 07/27/2023 09:37:29 
  }
  ```

- ### On Receiving a Message from WebSocket Hub 

  Source code URL: [processWebSocketMessageExchange](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc%2Fapp%2Fcore%2Fservices%2Fwebsocket.service.js&version=GBmaster&line=105&lineEnd=153&lineStartColumn=12&lineEndColumn=15&lineStyle=plain&_a=contents) 

  WebSocket onMessage event handler is triggered which does further processing of the data received.  

  Sample message
  ```
  {  
      ClientId: 6d674c0c-5403-4039-af8d-5c8dc6bfddfe, 
      SystemNameSender: "CargoWiseOne ",  
      SystemNameRecipient: "BorderWiseWeb",  
      Status: MSG,  
      Data: "BorderWiseWeb websocket connected.",  
      Type: Information,  
      MachineName: null,  
      Email: "testmail@ext",  
      Timestamp: 07/27/2023 09:37:29 
  }
  ```
 
- ### On Error in WebSocket Connection 

  Source Code URL: [onWebSocketConnectionError](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc%2Fapp%2Fcore%2Fservices%2Fwebsocket.service.js&version=GBmaster&line=73&lineEnd=81&lineStartColumn=16&lineEndColumn=19&lineStyle=plain&_a=contents) 

  The onError event is fired when there is an error during the WebSocket connection or communication process. This could happen due to various reasons, such as server unavailability, connection disruptions, or protocol errors. If an error is detected during the WebSocket communication, the code generates an error message indicating the client's WebSocket ID (webSocketClientId) and the corresponding event code. 


 