#!/usr/bin/env bash

set -e

echo "Installing moodle plugins"

cd /var/www/html/mod
curl -o d.zip https://moodle.org/plugins/download.php/28962/mod_checklist_moodle42_2023041400.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29393/mod_customcert_moodle41_2022112801.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29022/mod_game_moodle42_2023042500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29333/mod_mediagallery_moodle41_2023060200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28807/mod_attendance_moodle41_2023020107.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29607/mod_offlinequiz_moodle41_2023070701.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29322/mod_coursecertificate_moodle42_2023053000.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29419/mod_hvp_moodle42_2023061200.zip && unzip -o d.zip
# curl -o d.zip https://moodle.org/plugins/download.php/28449/mod_quizgame_moodle42_2022112200.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/blocks
curl -o d.zip https://moodle.org/plugins/download.php/28963/block_checklist_moodle42_2023041400.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29544/block_completion_progress_moodle42_2023063000.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29418/block_stash_moodle42_2023061200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29335/block_xp_moodle42_2023042403.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29329/block_game_moodle41_2023053101.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/13802/block_ranking_moodle41_2017050300.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/mod/book/tool
curl -o d.zip https://moodle.org/plugins/download.php/28584/booktool_wordimport_moodle41_2023021700.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/filter
curl -o d.zip https://moodle.org/plugins/download.php/24270/filter_syntaxhighlighter_moodle41_2021052101.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/lib/editor/atto/plugins
curl -o d.zip https://moodle.org/plugins/download.php/9418/atto_chemistry_moodle31_2015092900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/17250/atto_count_moodle35_2018062700.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/9419/atto_computing_moodle30_2015092900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/17168/atto_justify_moodle40_2018041600.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/24509/atto_morebackcolors_moodle41_2021062100.zip && unzip -o d.zip && mv ndunand-moodle-atto_morebackcolors-* morebackcolors
curl -o d.zip https://moodle.org/plugins/download.php/24505/atto_morefontcolors_moodle41_2021062100.zip && unzip -o d.zip && mv ndunand-moodle-atto_morefontcolors-* morefontcolors
rm d.zip

cd /var/www/html/enrol
curl -o d.zip https://moodle.org/plugins/download.php/21447/enrol_xp_moodle41_2020042901.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/admin/tool
curl -o d.zip https://moodle.org/plugins/download.php/26575/tool_bulkchangeprofilefields_moodle40_2022042900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28188/tool_clearbackupfiles_moodle41_2022121200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29622/tool_coursearchiver_moodle42_2023071200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/18375/tool_hidecourses_moodle41_2018112800.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/23370/tool_ribbons_moodle310_2021020400.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29321/tool_certificate_moodle42_2023053000.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29320/tool_datewatch_moodle42_2023053000.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29222/tool_uploadenrolmentmethods_moodle41_2023051500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28084/tool_migratehvp2h5p_moodle41_2022112900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29223/tool_redirects_moodle41_2023051100.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29045/tool_opcache_moodle41_2023010500.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/availability/condition
curl -o d.zip https://moodle.org/plugins/download.php/22786/availability_xp_moodle41_2020110900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/26314/availability_coursecompleted_moodle41_2022040400.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28755/availability_role_moodle41_2023010500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29000/availability_language_moodle42_2023042300.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/24360/availability_mobileapp_moodle311_2021060200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28754/availability_cohort_moodle41_2023010500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28760/availability_password_moodle41_2023010500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/16615/availability_stash_moodle41_2018050901.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29236/availability_othercompleted_moodle42_2023050310.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/11311/availability_badge_moodle31_2016020200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/16249/availability_enrol_moodle34_2018030900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/24334/availability_sectioncompleted_moodle40_2021052800.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29517/availability_maxviews_moodle42_2023062700.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/23733/availability_quizquestion_moodle311_2021031700.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/22196/availability_courseprogress_moodle310_2020070100.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/26564/availability_game_moodle40_2022042610.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/26392/availability_user_moodle41_2022040801.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29347/availability_relativedate_moodle42_2023060300.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/question/format/
curl -o d.zip https://moodle.org/plugins/download.php/27954/qformat_h5p_moodle41_2020071510.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/report
curl -o d.zip https://moodle.org/plugins/download.php/28589/report_extendedlog_moodle41_2023022000.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/24073/report_overviewstats_moodle311_2021050500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28315/report_coursesize_moodle41_2023010900.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/course/format
curl -o d.zip https://moodle.org/plugins/download.php/28680/format_tiles_moodle41_2023030500.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29327/format_remuiformat_moodle42_2023053000.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/theme
curl -o d.zip https://moodle.org/plugins/download.php/29152/theme_adaptable_moodle41_2022112306.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/local
curl -o d.zip https://moodle.org/plugins/download.php/21216/local_analytics_moodle38_2019070801.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29011/local_cohortrole_moodle42_2023042400.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29145/local_mailtest_moodle42_2023050600.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28813/local_maintenance_livecheck_moodle41_2023010500.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/grade/export
curl -o d.zip https://moodle.org/plugins/download.php/28966/gradeexport_checklist_moodle42_2023041400.zip && unzip -o d.zip
rm d.zip

cd /var/www/html/user/profile/field
curl -o d.zip https://moodle.org/plugins/download.php/5944/profilefield_cpf_moodle310_2014041700.zip && unzip -o d.zip
sed -i 's/\$cpf{\$c}/$cpf[$c]/g' /var/www/html/user/profile/field/cpf/field.class.php

curl -o d.zip https://moodle.org/plugins/download.php/27125/profilefield_autocomplete_moodle311_2022071900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/26013/profilefield_timestamp_moodle311_2022021700.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/22197/profilefield_masked_moodle310_2020080800.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/13216/profilefield_dynamicmultiselect_moodle32_2017021201.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/28148/profilefield_brasilufmunicipio_moodle41_2022120600.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/13215/profilefield_dynamicmenu_moodle32_2017021201.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/21799/profilefield_multiselect_moodle39_2020061800.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/23487/profilefield_associated_moodle310_2021021600.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/26428/profilefield_statictext_moodle40_2022041200.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/27042/profilefield_orcid_moodle40_2022070900.zip && unzip -o d.zip
curl -o d.zip https://moodle.org/plugins/download.php/29142/profilefield_conditional_moodle42_2023050600.zip && unzip -o d.zip
rm d.zip


cd /var/www/html/

curl https://codeload.github.com/cte-zl-ifrn/moodle__local_suap/tar.gz/refs/tags/0.2.037         | tar -zx && mv moodle__local_suap-* local/suap
curl https://codeload.github.com/cte-zl-ifrn/moodle__local_suap/tar.gz/refs/tags/0.2.037         | tar -zx && mv moodle__local_suap-* local/suap
curl https://codeload.github.com/cte-zl-ifrn/moodle__auth_suap/tar.gz/refs/tags/0.2.024          | tar -zx && mv moodle__auth_suap-* auth/suap
curl https://codeload.github.com/cte-zl-ifrn/moodle__block_suapattendance/tar.gz/refs/tags/0.1.0 | tar -zx && mv moodle__block_suapattendance-* blocks/suapattendance
curl https://codeload.github.com/cte-zl-ifrn/moodle__theme_moove/tar.gz/refs/tags/4.1.1.r1       | tar -zx && mv moodle__theme_moove-* theme/moove
