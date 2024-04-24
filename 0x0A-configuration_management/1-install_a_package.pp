# Install flask 2.1.0 from pip3
package { 'flask':
ensure => installed,
version => '2.1.0',
provider => 'gem'
}
