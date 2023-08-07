TODO

-	Continue with URLSessionHTTPClientRetrierDecorator tests, next step is to actually perform retry
-	Remove username, password and sessionId from URLSessionHTTPClient, replace with header injection, by doing that 
	it will be necessary to handle not only 409 HTTP Status but also 401 HTTP Status, probably with another decorator.
-	EndToEnd tests for remaining API
