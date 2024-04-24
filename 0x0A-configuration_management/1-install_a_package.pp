# Installing flask from pip3
package {'flask':
 name	=> 'flask',
 source	=> 'pip3',
 ensure	=> installed
}
