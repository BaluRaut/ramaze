#          Copyright (c) 2008 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the MIT license.

require 'tagz'

module Ramaze
  module Helper
    ##
    # Allows you to use some shortcuts for Tagz in your Controller.
    # use this inside your controller to directly build Tagz
    # Refer to the Tagz-documentation and testsuite for more examples.
    #
    # Usage:
    #
    #     tagz { h1_{ "Apples & Oranges" } }  #=> "<h1>Apples &amp; Oranges</h1>"
    #     tagz { h1_(:class => 'fruits&floots'){ 'Apples' } }
    #
    Tagz = ::Tagz
  end # Helper
end # Ramaze
