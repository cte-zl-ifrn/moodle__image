FROM php:8.1.27-apache-bullseye
# FROM php:8.2.13-apache-bullseye

ARG DEBIAN_FRONTEND=noninteractive
ARG MOODLE_VERSION=4.1.8

ADD build/php-extensions.sh /tmp/build/php-extensions.sh
ADD build/locale.gen /etc/locale.gen

RUN    apt update \
    && apt upgrade -y \
    && apt-get install -y cron poppler-utils graphviz aspell python3 vim \
    && /tmp/build/php-extensions.sh \
    && a2enmod headers \
    && chmod 777 /tmp \
    && chmod +t /tmp

RUN    curl -L https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.tar.gz | tar -zx --strip-components=1 \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && mkdir /var/moodledata \
    && chown -R www-data:www-data /var/moodledata

ADD src/ini/ /usr/local/etc/php/conf.d/
ADD src/shell/cron-crontab /var/spool/cron/crontabs/www-data
ADD src/shell/ /usr/local/bin/

ADD --chown=www-data:www-data src/php/ /var/www/html/

USER www-data

WORKDIR /var/www/html/mod
RUN curl -o d.zip https://moodle.org/plugins/download.php/28807/mod_attendance_moodle41_2023020107.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29393/mod_customcert_moodle41_2022112801.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30072/mod_checklist_moodle43_2023100200.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30759/mod_coursecertificate_moodle43_2023122800.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29333/mod_mediagallery_moodle41_2023060200.zip      && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30739/mod_hvp_moodle43_2023122500.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30531/mod_game_moodle43_2023111601.zip              && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30601/mod_offlinequiz_moodle41_2023070702.zip       && unzip -o d.zip && rm d.zip
# RUN curl -o d.zip https://moodle.org/plugins/download.php/28449/mod_quizgame_moodle42_2022112200.zip          && unzip -o d.zip && rm d.zip


WORKDIR /var/www/html/blocks
RUN curl -o d.zip https://moodle.org/plugins/download.php/13802/block_ranking_moodle41_2017050300.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29329/block_game_moodle41_2023053101.zip                && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30405/block_completion_progress_moodle43_2023110100.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30074/block_checklist_moodle43_2023100200.zip           && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30306/block_stash_moodle43_2023102000.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30581/block_xp_moodle43_2023100803.zip                  && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/mod/book/tool
RUN curl -o d.zip https://moodle.org/plugins/download.php/28584/booktool_wordimport_moodle41_2023021700.zip && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/filter
RUN curl -o d.zip https://moodle.org/plugins/download.php/24270/filter_syntaxhighlighter_moodle41_2021052101.zip && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/lib/editor/atto/plugins
RUN curl -o d.zip https://moodle.org/plugins/download.php/17168/atto_justify_moodle40_2018041600.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/17250/atto_count_moodle35_2018062700.zip          && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/24505/atto_morefontcolors_moodle41_2021062100.zip && unzip -o d.zip && rm d.zip && mv ndunand-moodle-atto_morefontcolors-* morefontcolors
RUN curl -o d.zip https://moodle.org/plugins/download.php/24509/atto_morebackcolors_moodle41_2021062100.zip && unzip -o d.zip && rm d.zip && mv ndunand-moodle-atto_morebackcolors-* morebackcolors
RUN curl -o d.zip https://moodle.org/plugins/download.php/9418/atto_chemistry_moodle31_2015092900.zip       && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/9419/atto_computing_moodle30_2015092900.zip       && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/lib/editor/tiny/plugins
RUN curl -o d.zip https://moodle.org/plugins/download.php/30652/tiny_preview_moodle41_2023010104.zip   && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30131/tiny_fontcolor_moodle43_2023101000.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30645/tiny_c4l_moodle43_2023120800.zip       && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/enrol
RUN curl -o d.zip https://moodle.org/plugins/download.php/30441/enrol_xp_moodle43_2023110700.zip && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/admin/tool
RUN curl -o d.zip https://moodle.org/plugins/download.php/18375/tool_hidecourses_moodle41_2018112800.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/23370/tool_ribbons_moodle310_2021020400.zip                && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/26575/tool_bulkchangeprofilefields_moodle40_2022042900.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30840/tool_migratehvp2h5p_moodle43_2024011100.zip          && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/28188/tool_clearbackupfiles_moodle41_2022121200.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30832/tool_userdebug_moodle43_2024010900.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29222/tool_uploadenrolmentmethods_moodle41_2023051500.zip  && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29223/tool_redirects_moodle41_2023051100.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30729/tool_coursearchiver_moodle43_2023122100.zip          && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30758/tool_certificate_moodle43_2023122800.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30161/tool_datewatch_moodle43_2023101000.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30230/tool_opcache_moodle41_2023010501.zip                 && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/availability/condition
RUN curl -o d.zip https://moodle.org/plugins/download.php/30440/availability_xp_moodle43_2023110700.zip               && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30203/availability_coursecompleted_moodle43_2023101400.zip  && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30215/availability_role_moodle41_2023010501.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30198/availability_language_moodle43_2023101400.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/24360/availability_mobileapp_moodle311_2021060200.zip       && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30213/availability_cohort_moodle41_2023010501.zip           && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30214/availability_password_moodle41_2023010501.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30751/availability_stash_moodle43_2023122800.zip            && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29236/availability_othercompleted_moodle42_2023050310.zip   && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/11311/availability_badge_moodle31_2016020200.zip            && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/16249/availability_enrol_moodle34_2018030900.zip            && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/24334/availability_sectioncompleted_moodle40_2021052800.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29517/availability_maxviews_moodle42_2023062700.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/23733/availability_quizquestion_moodle311_2021031700.zip    && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/22196/availability_courseprogress_moodle310_2020070100.zip  && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/26564/availability_game_moodle40_2022042610.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/26392/availability_user_moodle41_2022040801.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30644/availability_relativedate_moodle43_2023120800.zip     && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/question/format/
RUN curl -o d.zip https://moodle.org/plugins/download.php/27954/qformat_h5p_moodle41_2020071510.zip && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/report
RUN curl -o d.zip https://moodle.org/plugins/download.php/30818/report_extendedlog_moodle43_2024010800.zip    && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30535/report_overviewstats_moodle43_2023112100.zip  && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/28315/report_coursesize_moodle41_2023010900.zip     && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/course/format
RUN curl -o d.zip https://moodle.org/plugins/download.php/28680/format_tiles_moodle41_2023030500.zip          && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30839/format_remuiformat_moodle43_2024011000.zip    && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/theme
RUN curl -o d.zip https://moodle.org/plugins/download.php/30468/theme_adaptable_moodle41_2022112308.zip       && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/local
RUN curl -o d.zip https://moodle.org/plugins/download.php/21216/local_analytics_moodle38_2019070801.zip             && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30117/local_cohortrole_moodle43_2023100900.zip            && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30333/local_mailtest_moodle43_2023102300.zip              && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/30221/local_maintenance_livecheck_moodle41_2023010501.zip && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/grade/export
RUN curl -o d.zip https://moodle.org/plugins/download.php/30077/gradeexport_checklist_moodle43_2023100200.zip       && unzip -o d.zip && rm d.zip

WORKDIR /var/www/html/user/profile/field
RUN curl -o d.zip https://moodle.org/plugins/download.php/5944/profilefield_cpf_moodle310_2014041700.zip            && unzip -o d.zip && rm d.zip \
    && sed -i 's/\$cpf{\$c}/$cpf[$c]/g' /var/www/html/user/profile/field/cpf/field.class.php

RUN curl -o d.zip https://moodle.org/plugins/download.php/27125/profilefield_autocomplete_moodle311_2022071900.zip      && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/26013/profilefield_timestamp_moodle311_2022021700.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/22197/profilefield_masked_moodle310_2020080800.zip            && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/13216/profilefield_dynamicmultiselect_moodle32_2017021201.zip && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/28148/profilefield_brasilufmunicipio_moodle41_2022120600.zip  && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/13215/profilefield_dynamicmenu_moodle32_2017021201.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/21799/profilefield_multiselect_moodle39_2020061800.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/23487/profilefield_associated_moodle310_2021021600.zip        && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/26428/profilefield_statictext_moodle40_2022041200.zip         && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/27042/profilefield_orcid_moodle40_2022070900.zip              && unzip -o d.zip && rm d.zip
RUN curl -o d.zip https://moodle.org/plugins/download.php/29142/profilefield_conditional_moodle42_2023050600.zip        && unzip -o d.zip && rm d.zip


WORKDIR /var/www/html/

RUN curl https://codeload.github.com/cte-zl-ifrn/moodle__local_suap/tar.gz/refs/tags/0.2.053t         | tar -zx && mv moodle__local_suap-* local/suap
RUN curl https://codeload.github.com/plaforedu/pnp/tar.gz/refs/tags/1.0.2                             | tar -zx && mv pnp-* local/pnp
RUN curl https://codeload.github.com/cte-zl-ifrn/moodle__enrol_suap/tar.gz/refs/tags/1.0.001          | tar -zx && mv moodle__enrol_suap-* enrol/suap
RUN curl https://codeload.github.com/cte-zl-ifrn/moodle__auth_suap/tar.gz/refs/tags/0.2.025           | tar -zx && mv moodle__auth_suap-* auth/suap
RUN curl https://codeload.github.com/cte-zl-ifrn/moodle__block_suapattendance/tar.gz/refs/tags/0.1.0  | tar -zx && mv moodle__block_suapattendance-* blocks/suapattendance
RUN curl https://codeload.github.com/cte-zl-ifrn/moodle__theme_moove/tar.gz/refs/tags/4.1.1.r4t       | tar -zx && mv moodle__theme_moove-* theme/moove

# Removeds:
# theme_aberto, theme_ead, theme_ledor 
# mod_bigbluebuttonbn, mod_hsuforum, mod_journal, mod_questionnaire, mod_vpl
# filter_h5p
# availability_days, availability_week, availability_enroldate, availability_dataformcontent

ADD build/extra.ini /usr/local/etc/php/conf.d/extra.ini


# USER root
USER www-data
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
