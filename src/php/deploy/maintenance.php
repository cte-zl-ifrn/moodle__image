<?php
require_once('config_get_envs.php');
include_once('vendor/autoload.php');
include_once('deploy/maintenance_freshstatus.php');

class Link {
    public $url = null;
    public $label = null;

    function __construct(string $label, string $url) {
        $this->url = $url;
        $this->label = $label;
    }
}

function render_maintenance_message($links) {
    $all_links = '';
    if ( count($links) > 0 ) {
        $all_links = '<cite><p>Caso você precise, você sempre pode entrar em contado conosco por qualquer um dos canais abaixo:</p><ul>';
        foreach ($links as $link) {
            $all_links .= "<li><a href=\"{$link->url}\">{$link->label}</a></li>";
        }
        $all_links .= '</ul></cite>';
    }

    return <<<EOT
    <!doctype html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Estamos em manutenção</title>
      <style>
        body { text-align: center; padding: 150px; background: #00AFF9; color: #fafafa; font: 20px Helvetica, sans-serif; }
        article { display: block; text-align: left; width: 650px; margin: 0 auto; height: 520px; background-size: 100%; }
        h1 { font-size: 50px; }
        a { color: #fafafa; text-decoration: underline; }
        cite { display: block; font-size: 85%; margin: 0 0 0 2em; border-left: 4px solid #fff; padding: 1px 0.5em !important; }
      </style>
    </head>
    <body>
      <article>
          <h1>Voltaremos logo!</h1>
          <h2>Manutenção.</h2>
          <div>
              <p>Desculpe pelo transtorno, mas estamos realizando uma manutenção no momento e voltaremos ao ar em poucos minutos.</p>
              {$all_links}
              <p>&mdash; CTE/ZL/IFRN.</p>
          </div>
      </article>
    </body>
    </html>
    EOT;
}

function start_maintenance() {
    $links = [];

    $email = get_env('CFG_ADMIN_MAIL', null);
    if ( $email != null ) {
        $links[] = new Link($email, "mailto://{$email}");
    }

    $freshstatusClient = new FreshstatusClient();
    if ( $freshstatusClient->configured ) {
        $release = file_get_contents('/var/www/html/tag_version.txt');
        $incident = $freshstatusClient->create_incident($release);
        if ( $incident != null ) {
            file_put_contents('/var/moodledata/freshstatus_incident.id', "{$incident->id}");
            $links[] = new Link('Fórum', "{$freshstatusClient->baseurl}/incident/{$incident->id}");
            $links[] = new Link('Notícia desta atualização', "{$freshstatusClient->baseurl}/support/solutions");
            $links[] = new Link('Histórico de atualizações', "{$freshstatusClient->baseurl}/");
        }
    }

    $content = render_maintenance_message($links);
    file_put_contents('/var/moodledata/climaintenance.html', $content);

    try_connect_pg();    
}

function stop_maintenance() {
    $filename = '/var/moodledata/climaintenance.html';
    if ( file_exists($filename) ) {
        unlink($filename);
    }
    $filename = '/var/moodledata/freshstatus_incident.id';
    if ( file_exists($filename) ) {
        $incident_id = file_get_contents($filename);
        (new FreshstatusClient())->resolve_incident($incident_id);
        unlink($filename);
    }
}

function try_connect_pg() {
    $dbhost = get_env('CFG_DBHOST', get_env('POSTGRES_HOST', 'db'));
    $dbname = get_env('CFG_DBNAME', get_env('POSTGRES_DATABASE', 'postgres'));
    $dbuser = get_env('CFG_DBUSER', get_env('POSTGRES_USER', 'postgres'));
    $dbpass = get_env('CFG_DBPASS', get_env('POSTGRES_PASSWORD', 'postgres'));
    $dbport = get_env('CFG_DBPORT', get_env('POSTGRES_PORT', '5432'));

    $connected = false;
    $try = 0;
    while (!$connected) {
        $try++;
        $connection = pg_connect("host=$dbhost port=$dbport dbname=$dbname user=$dbuser password=$dbpass");
        if($connection) {
            echo "Connected.";
            $connected = true;
        } else {
            echo "Conexão: $try";
        }
        sleep(5);
    }
}

function main() {
    if (count($_SERVER['argv']) <= 1) {
        die("Informe ao menos start ou stop");
    }
    
    $cmd = $_SERVER['argv'][1];
    switch ($cmd) {
        case 'start': start_maintenance(); break;
        case 'stop': stop_maintenance(); break;
        default: die("Você teria que ter informado start ou stop, mas informou $cmd ."); break;
    }
}

main();
