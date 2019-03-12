{                        
    "commandToExecute": "apt-get update -y > /dev/null && apt-add-repository ppa:ansible/ansible > /dev/null  && echo 'bootscript done' > /tmp/result.txt && ansible --version >> /tmp/result.txt"
}
