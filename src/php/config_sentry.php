<?php
use Sentry\Tracing\SpanContext;

// Function that makes the code run after everythings.
function sentry_finish_shutdown()
{
    \Sentry\captureLastError();
    $transaction = \Sentry\getCurrentTransaction();
    
    if ($transaction) { 
        $transaction->finish();  
    }
}

$sentry_dsn = env('SENTRY_DSN', $default=null);
if ($sentry_dsn) {
    register_shutdown_function('sentry_finish_shutdown');

    $CFG->sentry_dsn = $sentry_dsn;
    include_once (__DIR__ . '/vendor/autoload.php');
    \Sentry\init([
        'dsn' => $sentry_dsn, 
        'release' => env('SENTRY_RELEASE', null),
        'environment' => env('SENTRY_ENVIRONMENT', 'local'),
        'error_types' => env('SENTRY_ERROR_TYPESz', E_ALL),
        'sample_rate' => env_int('SENTRY_SAMPLE_RATE', 100) / 100.0,
        'max_breadcrumbs' => env_int('SENTRY_MAX_BREADCRUMBS', 100),
        'attach_stacktrace' => env_bool('SENTRY_ATTACH_STACKTRACE', false),
        'send_default_pii' => env_bool('SENTRY_SEND_DEFAULT_PII', true),
        'server_name' => env('SENTRY_SERVER_NAME', $_ENV['HOSTNAME']),
        // 'in_app_include' => env('SENTRY_', null),
        // 'in_app_exclude' => env('SENTRY_', null),
        'max_request_body_size' => env('SENTRY_MAX_REQUEST_BODY_SIZE', 'small'),
        'max_value_length' => env('SENTRY_MAX_VALUE_LENGTH', 1024),
        // 'before_send' => env('SENTRY_', null),
        // 'before_breadcrumb' => env('SENTRY_', null),
        'traces_sample_rate' => env_int('SENTRY_TRACES_SAMPLE_RATE', 100) / 100.0,
        // 'traces_sampler' => env('SENTRY_', null),
        // 'default_integrations' => env_bool('SENTRY_DEFAULT_INTEGRATIONS', true),
        // 'integrations' => [
        //     new \Sentry\Integration\ModulesIntegration(),
        // ],
    ]);
}
