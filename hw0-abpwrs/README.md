# ECE:5820/CS:5820, SELT, Fall 2018
## Homework 0

Due: Monday August 27, 2018 by 11:30am

***

INTENT:  This is a multi-part assignment to assist you with configuring your development environment.

### REQUIREMENT 1:  Instructions for setting up and using your Github Account

In this class we will use a cloud-based repository service called GitHub.  
To get started with GitHub, you need to carefully follow the steps below:

1. Request a free GitHub educational account as follows (if you already have a GitHub account,
   skip this step and proceed to Step 2):
1. Go to: `github.com` and sign up for an account (be sure to use your university e-mail address)
1. Go to the site:  `https://education.github.com/pack`
1. Click on one of the "Get your pack" button
1. Sign-in with your account name and password (HINT: Using your name@uiowa.edu email address will greatly
   accelerate the process of verifying that you are a student.  )
1. Fill in the requested information, identifying yourself as a student and specifying 
   that you are looking to get a discount for an individual account.
1. After you have submitted your request, you should get an e-mail message from
   GitHub indicating that you have been upgraded to a free Micro Plan.  (This will allow you maintain 
   up to five private repositories in addition to an unlimited number of public ones.) 
   The GitHub site indicates that it may take up to a week to get the discounted plan.  
   However, it will probably take only a few minutes if you use your university e-mail address.

   
### REQUIREMENT 2: Configure your primary development environment

The process of configuring a development environment suitable for matching the book content
is slightly different for every operating system, and every operating system version.  Software development
at the level introduced in SELT has a heavy dependence on UNIX conventions and tools.

We require:
    1. RubyMine 2018.2 or greater (NOTE: The book suggests cloud9, but that service is not available anymore)
    2. nbenv (NOTE: the book suggests RVM, but more modern recommendation is to use nbenv)
    2. Ruby version 2.5.1 (A version greater than 2.4 is required for modern OS with openssl 1.1 or greater)
    3. Rails version 5.2.1 (Some online examples require 5.0.0 or greater.) 

1. Install RubyMine (See instructions for getting a free student license).
https://uiowa.instructure.com/courses/82326/pages/install-rubymine

1. Configure and install ruby environment following general instructions on gorails.com site. 
    YOU DO NOT NEED TO INSTALL THE LOCAL DATABASES
    - https://uiowa.instructure.com/courses/82326/pages/install-instructions-for-engineering-computers
    - https://uiowa.instructure.com/courses/82326/pages/install-instructions-for-personal-mac
    - https://uiowa.instructure.com/courses/82326/pages/install-instructions-for-personal-windows-computer


### REQUIREMENT 3:  Configure your Github account

1. [Optional] Add additional email accounts https://github.com/settings/emails
1. Upload a new picture https://github.com/settings/profile.  
   NOTE: The profile picture can be anything you want, but you must replace the default picture.
1. Create new SSH key for this course and 
   Get help at https://help.github.com/articles/connecting-to-github-with-ssh/
   
   ```bash
   % mkdir -p ~/.ssh         # Make a ~/.ssh directory in your home account if needed
   % chmod -R 700 ~/.ssh     # Restrict permissions on the .ssh directory
   
   # These commans are hints that may help you, but should be understood rather than blindly copied
      
   # NOTE:  I recommend AGAINST using the default ssh filename.  It is better to choose a meaningful
   #        file name for selt credentials.
   #        The following command will create two new credential files
   #              private: ~/.ssh/yourhawkid_selt_rsa4096
   #              public:  ~/.ssh/yourhawkid_selt_rsa4096.pub
   
   % ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/yourhawkid_selt_rsa4096
   % chmod -R 600 ~/.ssh/*   # Restrict permissions on the ssh keys
   
   # NOTE: You only need to create the key pair one time, after that you should copy the files
           to your restricted permission ~/.ssh directories on each of your computer envirionments.
   # NOTE: The public file can be shared with anybody and is not considered a sensitive file.
   #       The private file IS VERY SENSITIVE and should not be shareed with anyone else.          
   ```

1. Add your newly created public key to github following the instructions here: 
https://github.com/settings/keys, and https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

### REQUIREMENT 4: Configure your local computer git environment

1. [OPTIONAL] Each time you start a new shell environment (i.e. new terminal window), you can 
   create an `ssh-agent` process to manage your credentials (to avoid typing passwords all the time).  
   See instructions here: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent
2. 
   ```bash
   # This step must be done on each computer system that you use.
   # Replace the example name and email address in the following steps with the ones you used
   # for your Github account.
   git config --global color.ui true
   git config --global user.name "YOUR NAME"
   git config --global user.email "YOUR@EMAIL.com"
   
   #[OPTIONAL]
   git config --global core.editor <<You favorite editor>> # vim, emacs, nano, pico, atom
   
   #[OPTIONAL] review the config change you made
   cat ~/.gitconfig
   ```



### REQUIREMENT 5: Checkout hw0fall2018 and run inside of RubyMine

1. Clone your version of hw0fall2018 git repository to your development environment.
1. Start RubyMine
1. Configure RubyMine to use the installed 2.5.1 ruby environment
1. Wait for RubyMine to complete indexing of your project.
1. Run the hw0.rb file
1. Paste the console output into the Canvas Quiz indicating that you completed the assignment. https://uiowa.instructure.com/courses/82326/quizzes/109815

HINT:  Short video to demonstrate the desired actions. https://uiowa.instructure.com/files/7068638/download?wrap=1

