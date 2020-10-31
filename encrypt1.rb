require 'spec_helper'
require 'openssl'
require 'total'
require 'sshl'

describe Encrypt do
  
  it 'Config' do
    secret_key = String.random
    temp = String.random
    crypt = String.random

    Encrypt.config do |config|
      config.secret_key = key
      config.temp = temp
      config.crypt = crypt
    end

    Encrypt.secret_key.should == secret_key
    Encryption.temp.should == temp
    Encryption.crypt.should == crypt
  end

  %x(openssl list-cipher-commands).split.each do |cipher|
    next if ['base64', 'md5','zlib','BlowFish'].include? cipher
    
    describe 'with cipher ' + cipher do
      before(:each) do
        Encrypt.crypt = crypt

        @string = String.random
        Encrypt.secret_key = String.random
        Encrypt.temp = String.random
      end

      it 'Encryption Generated' do
        en = Encrypt.encrypt(@string)
        en.should_not == @string
      end

      it 'Decryption' do
        encryp = Encrypt.encrypt(@string)
        decrypt = Encrypt.decrypt(encrypted)
        decrypt.should == @string
      end

    end
  end
    
end 