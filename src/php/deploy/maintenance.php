<?php
require_once('readenv.php');
// include_once('vendor/autoload.php');

class Link {
    public $url = null;
    public $label = null;

    function __construct(string $label, string $url) {
        $this->url = $url;
        $this->label = $label;
    }
}

function render_maintenance_message($links, $firstname, $lastname) {
    $all_links = '';
    if ( count($links) > 0 ) {
        $all_links = '<cite><p>Caso você precise, você sempre pode entrar em contado conosco por qualquer um dos canais abaixo:</p><ul>';
        foreach ($links as $link) {
            $all_links .= "<li><a href=\"{$link->url}\">{$link->label}</a></li>";
        }
        $all_links .= '</ul></cite>';
    }

    $inicio = date('Y-m-d H:i:s');

    return <<<EOT
    <!doctype html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <meta http-equiv="refresh" content="60">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Estamos em manutenção</title>
      <style>
        body { text-align: center; padding: 150px; background: #00AFF9; color: #fafafa; font: 20px Helvetica, sans-serif; }
        article { display: block; text-align: left; width: 650px; margin: 0 auto; height: 520px; background-size: 100%; }
        h1 { font-size: 50px; }
        h2 { font-size: 40px; margin-bottom: 0; }
        h3 { font-size: 70%; font-weight: 500; font-style: italic; margin: 0; padding: 0; }
        a { color: #fafafa; text-decoration: underline; }
        cite { display: block; font-size: 85%; margin: 0 0 0 2em; border-left: 4px solid #fff; padding: 1px 0.5em !important; }
      </style>
    </head>
    <body>
      <article>
          <h1>Voltaremos logo!</h1>
          <h2>Manutenção.</h2>
          <h3>Desde $inicio</h3>
          <div>
              <p>Pedimos desculpas pelo inconveniente, mas estamos realizando uma manutenção no momento. Voltaremos ao ar em breve.</p>
              <p>Fique tranquilo! Esta página será atualizada automaticamente assim que o sistema estiver de volta ao normal.</p>
              {$all_links}
              <p>&mdash; $firstname$lastname.</p>
          </div>
      </article>
    </body>
    </html>
    EOT;
}

function start_maintenance() {
    $firstname = env('CFG_ADMINFIRSTNAME', 'CTE/ZL');
    $lastname = env('CFG_ADMINLASTNAME', '/IFRN');
    $email = env('CFG_ADMINEMAIL', 'user@localhost');
    $links = [new Link($email, "mailto://{$email}")];
    file_put_contents(
        '/var/moodledata/climaintenance.html', 
        render_maintenance_message($links, $firstname, $lastname)
    );

    // try_connect_pg();    
}

function stop_maintenance() {
    $filename = '/var/moodledata/climaintenance.html';
    if ( file_exists($filename) ) {
        unlink($filename);
    }
}

function try_connect_pg() {
    $dbhost = env('CFG_DBHOST', env('POSTGRES_HOST', 'db'));
    $dbname = env('CFG_DBNAME', env('POSTGRES_DATABASE', 'postgres'));
    $dbuser = env('CFG_DBUSER', env('POSTGRES_USER', 'postgres'));
    $dbpass = env('CFG_DBPASS', env('POSTGRES_PASSWORD', 'postgres'));
    $dbport = env('CFG_DBPORT', env('POSTGRES_PORT', '5432'));

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
