<?php
use Sentry\Tracing\SpanContext;

$CFG->sentry_dsn = get_env('CFG_SENTRY_DSN', $default=null);

if ($sentry_dsn) {
    // Function that makes the code run after everythings.
    function sentry_finish_shutdown()
    {
        \Sentry\captureLastError();
        $transaction = \Sentry\getCurrentTransaction();
        
        if ($transaction) { 
            $transaction->finish();  
        }
    }

    $CFG->sentry_dsn = get_env('CFG_SENTRY_DSN', $default=null);
    include_once (__DIR__ . '/vendor/autoload.php');

    register_shutdown_function('sentry_finish_shutdown');
}
