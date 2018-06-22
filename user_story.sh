#!/bin/bash
get_rnd_user(){
  shuf -n 1 users_list.txt
}
get_rnd_role(){
  shuf -n 1 users_roles.txt
}
test_role(){
  roles=$1
  for item in "${roles[@]}";
  do
    [[ "$2" == "$item" ]] && test_role $1 $(get_rnd_role);
  done
  echo $2
}
generate_roles(){
  declare -a roles=()
  for i in 1 2 3 4 5 6 7 8 9 10
  do
    user=$(get_rnd_user)
    rnd_role=$(get_rnd_role)
    #role=$(test_role $roles $rnd_role)
    role=$(get_rnd_role)
    #roles[${#roles[@]}]=$role
    echo "<a href="http://tilde.town/~$user">$user</a> is the $role<br>"
  done
}
cat /etc/passwd | grep "/home" |cut -d: -f1 > users_list.txt
echo "
  <!DOCTYPE html>
    <head>
      <link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">
    </head>
    <body>

      <div id=\"generated_list\">
        <p>
          $(generate_roles)
        </p>
      </div>

    </body>
  </html>
" > index.html
chmod o-w index.html
