<?php

function get_env(string $varname, $default=null) {
    $value = getenv($varname, true);
    return $value === false ? $value : $default;
}

function get_env_bool(string $varname, $default='false') {
    return strtolower(get_env($varname, $default)) == 'true';
}

function get_env_int(string $varname, $default='false') {
    return (int)(get_env($varname, $default));
}
