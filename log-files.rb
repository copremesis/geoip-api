
#WIP 
#manually editing after each upload
#after each upload
#would like to:
#* build py-dict
#* update this hash/dictionary
#* update template in UI (or make it dynamic reads the fs and build the option list dynamically)
#* rebuild map
LOG_FILES = { 
  'auth.log.4.gz' => { 
     source: 'uploads/auth.log.4.gz', 
     dict: 'auth4_dict.py',
  },
  'auth.log.3.gz' => { 
     source: 'uploads/auth.log.3.gz',
     dict: 'auth3_dict.py'
  },
  'auth.log.2.gz' => { 
    source: 'uploads/auth.log.2.gz',
    dict: 'auth2_dict.py'
  },
  'auth.log.1.gz' => { 
    source: 'uploads/auth.log.1.gz',
    dict:   'auth1_dict.py'
  },
  'ufw.log.gz'    =>  {
    source: 'uploads/ufw.log.gz',
    dict: 'ufw_log_dict.py'
  },
  'ufw.log.1.gz'  =>  {
    source: 'uploads/ufw.log.1.gz',
    dict:  'ufw_log_dict.py'
  },
  'secure-apr-2024.gz'  => {
    source:  'uploads/secure-apr-2024.gz',
    dict: 'centos_ssh_dict.py'
  },
  'messages-2024.gz'  => {
    source:  'uploads/messages-2024.gz',
    dict: 'centos_db_dict.py'
  },
  'ufw.log-gnomecraft.gz'  => {
    source:  'uploads/ufw.log-gnomecraft.gz',
    dict: 'ufw_log_gnomecraft.py'
  },
  'ufw.log-bastion.gz'  => {
    source:  'uploads/ufw.log-bastion.gz',
    dict: 'ufw_log_bastion.py'
  },
  'ufw-adipocere.gz'  => {
    source:  'uploads/ufw-adipocere.gz',
    dict: 'ufw_log_adipocere.py'
  },
  'messages-20240526.gz'  => {
    source:  'uploads/messages-20240526.gz',
    dict: 'centos_messages_20240526.py'
  },
  'ufw-adipocere-june-2024.gz'  => {
    source:  'uploads/ufw-adipocere-june-2024.gz',
    dict: 'ufw_log_adipocere_june2024.py'
  }
}
