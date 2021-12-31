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

$sentry_dsn = get_env('SENTRY_DSN', $default=null);
if ($sentry_dsn) {
    register_shutdown_function('sentry_finish_shutdown');

    $CFG->sentry_dsn = $sentry_dsn;
    include_once (__DIR__ . '/vendor/autoload.php');
    \Sentry\init([
        'dsn' => $sentry_dsn, 
        'release' => get_env('SENTRY_RELEASE', null),
        'environment' => get_env('SENTRY_ENVIRONMENT', 'local'),
        'error_types' => get_env('SENTRY_ERROR_TYPESz', E_ALL),
        'sample_rate' => get_env_int('SENTRY_SAMPLE_RATE', 100) / 100.0,
        'max_breadcrumbs' => get_env_int('SENTRY_MAX_BREADCRUMBS', 100),
        'attach_stacktrace' => get_env_bool('SENTRY_ATTACH_STACKTRACE', false),
        'send_default_pii' => get_env_bool('SENTRY_SEND_DEFAULT_PII', true),
        'server_name' => get_env('SENTRY_SERVER_NAME', $_ENV['HOSTNAME']),
        // 'in_app_include' => get_env('SENTRY_', null),
        // 'in_app_exclude' => get_env('SENTRY_', null),
        'max_request_body_size' => get_env('SENTRY_MAX_REQUEST_BODY_SIZE', 'small'),
        'max_value_length' => get_env('SENTRY_MAX_VALUE_LENGTH', 1024),
        // 'before_send' => get_env('SENTRY_', null),
        // 'before_breadcrumb' => get_env('SENTRY_', null),
        'traces_sample_rate' => get_env_int('SENTRY_TRACES_SAMPLE_RATE', 100) / 100.0,
        // 'traces_sampler' => get_env('SENTRY_', null),
        // 'default_integrations' => get_env_bool('SENTRY_DEFAULT_INTEGRATIONS', true),
        // 'integrations' => [
        //     new \Sentry\Integration\ModulesIntegration(),
        // ],
    ]);
}
