
    protected function query_start($sql, array $params=null, $type, $extrainfo=null) {
        global $CFG, $USER, $COURSE, $THEME;

        if ((property_exists($CFG, 'sentry_dsn')) && ($CFG->sentry_dsn)) {
            Sentry\init([
                'dsn' => $CFG->sentry_dsn, 
                'traces_sample_rate' => 1.0,
            ]);
    
            $this->last_sql       = $sql;
            $this->last_params    = $params;
            $this->last_type      = $type;
            $this->last_extrainfo = $extrainfo;
            $this->last_time      = microtime(true);
            //Add operations and data to the span in a current hub
            $spanContext = Sentry\getCurrentSpanContext();
            if ($spanContext) {
                $spanContext->setOp($this->last_sql);
                $spanContext->setData(['Params'=>$this->last_params]);
                $tags = $spanContext->getTags();
                // Configure the scope to add a personal tag
                \Sentry\configureScope(function (\Sentry\State\Scope $scope): void {
                    global $CFG, $USER, $COURSE, $PAGE, $THEME;
                    $spanContext = Sentry\getCurrentSpanContext();
                    $spanContext->setOp($this->last_sql);
                    $spanContext->setData(['Params'=>$this->last_params]);
                    $tags = $spanContext->getTags();
                    if (!$tags) {
                        $tags = [];
                    }
                    
                    if ($USER) {
                        $tags['user_id'] = $USER->id;
                    }

                    if ($COURSE) {
                        $tags['course_id'] = $COURSE->id;
                    }

                    $scope->setTags($tags);
                });

                $spanContext->setTags($tags);
                $spanContext->setStartTimestamp(microtime(true));
            }
            //Add span to the current transaction
            $transaction = Sentry\getCurrentTransaction();
            if ($transaction) {
                $this->last_span = $transaction->startChild(Sentry\getCurrentSpanContext());
            }
            //Create breadcrumb
            $bread_crumb = new Breadcrumb("info", 'default', 'query', $this->last_sql);
            \Sentry\addBreadcrumb($bread_crumb);
        }

        self->query_start_original($sql, $params, $type, $extrainfo);
    }

    protected function query_end($result) {
        global $CFG;
        //Finish the spancontext
        if ((property_exists($CFG, 'sentry_dsn')) && ($CFG->sentry_dsn)) {
            $resposta['mensagem'] = $this->last_params; 

            if ($this->last_span) {
                $this->last_span -> finish();
            }
            //Get the end time
            $spanContext = Sentry\getCurrentSpanContext();
            if ($spanContext) {
                $spanContext->setEndTimestamp(microtime(true));
            }
            
        }

        self->query_end_original($result);
    }
}