<?php
class FreshstatusClient {

    // https://support.freshstatus.io/support/solutions/articles/50000003646-freshstatus-api-documentation

    public $configured = false;
    public $domain = null;
    public $api_key = null;
    public $component_id = null;

    public $source = null;

    public $baseurl = null;

    function __construct() {
        $this->domain = get_env('FRESHSTASUS_DOMAIN', null);
        $this->api_key = get_env('FRESHSTASUS_API_KEY', null);
        $this->component_id = get_env('FRESHSTASUS_COMPONENT_ID', null);
        $this->source = get_env('FRESHSTASUS_SOURCE_ID', null);

        $this->baseurl = "https://{$this->domain}.freshstatus.io";

        $this->configured = ( ($this->domain != null) && ($this->api_key != null)  && ($this->component_id != null) );
    }

    function dt_fmt(): string {
        return (new DateTime())->format('Y-m-d\TH:i:s') . 'Z';
    }

    function post(string $url, $body=null) {
        if ( $body != null ) {
           $headers = [ 'auth' => [$this->api_key, $this->domain], 'Content-Type' => 'application/json', 'json' => $body];
        } else {
            $headers = [ 'auth' => [$this->api_key, $this->domain], 'Content-Type' => 'application/json'];
        }

        $response = (new GuzzleHttp\Client())->request('POST', $url, $headers);
        return json_decode($response->getBody());
    }

    function create_incident(string $release) {
        if ( !$this->configured ) {
            return null;
        }
        return $this->post(
            'https://public-api.freshstatus.io/api/v1/incidents/',
            [
                "title" => "Evolução de versão do AVA para a versão $release",
                "description" => "Regularmente a versão do AVA é atualizada por questão de segurança, melhoria ou correção de bug. Esta é mais uma evolução.",
                "start_time" => $this->dt_fmt(),
                "end_time" => $this->dt_fmt(),
                "is_private" => false,
                "affected_components" => [
                    [
                        "component" => $this->component_id,
                        "new_status" => "UM"
                    ]
                ],
                "source" => $this->source,
                "notification_options" => [
                    "send_tweet" => "false",
                    "send_email" => "false"
                ]
            ]
        );
    }

    function resolve_incident(int $incident_id) {
        if ( !$this->configured ) {
            return null;
        }
        return $this->post("https://public-api.freshstatus.io/api/v1/incidents/{$incident_id}/resolve/");
    }

}
