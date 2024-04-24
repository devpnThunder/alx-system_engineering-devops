# Install flask 2.1.0 from pip3
package { 'flask':
  ensure   => '2.5.0',
  provider => 'gem',
}
