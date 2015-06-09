module Authentication
  module ByPassword
    module ClassMethods
      
    end
    
    module InstanceMethods

      # Encrypts the password with the user features
      # generate features by make_token method
      def encrypt(psword)
        # self.class.secure_digest(psword, features)
        self.class.secure_digest(psword)
      end

      def authenticated?(psword)
        password == encrypt(psword)
      end
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods

      ## other way
      # recipient.class_eval do
      #   include InstanceMethods
      # end
    end
  end
end