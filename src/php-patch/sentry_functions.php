
function init(array $options = [])
{
    global $sentryClientSingleton, $sentryTransactionSingleton, $sentrySpanContextSingleton;

    if($sentryClientSingleton == null){
        
        $sentryClientSingleton = ClientBuilder::create($options)->getClient();
        SentrySdk::getCurrentHub()->bindClient($sentryClientSingleton);
        //Start transaction
        $transactionContext = new \Sentry\Tracing\TransactionContext();
        $transactionContext -> setName($_SERVER['REQUEST_URI']);
        $transactionContext -> setOp('http.caller');
        $sentryTransactionSingleton = \Sentry\startTransaction($transactionContext);
        \Sentry\SentrySdk::getCurrentHub()->setSpan($sentryTransactionSingleton);
        //Start SpanContext
        $sentrySpanContextSingleton = new \Sentry\Tracing\SpanContext();
    }

    return $sentrySpanContextSingleton;    

}

function getCurrentTransaction(){
    global $sentryTransactionSingleton;

    return $sentryTransactionSingleton;
}

function getCurrentSpanContext(){
    global $sentrySpanContextSingleton;

    return $sentrySpanContextSingleton;
}
