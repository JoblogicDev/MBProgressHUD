Pod::Spec.new do |s|
  s.name             = 'JoblogicMBProgressHUD'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MBProgressHUD.'
  s.description      = <<-DESC
  A longer description of YourLibraryName in Markdown format.
  DESC
  s.homepage         = 'https://joblogicltd.visualstudio.com/JobLogic%20Mobile/_git/joblogic-mobile-ios-library-MBProgressHUD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'duyb@joblogic.com' }
  s.source           = { :git => 'joblogicltd@vs-ssh.visualstudio.com:v3/joblogicltd/JobLogic%20Mobile/joblogic-mobile-ios-library-MBProgressHUD', :tag => 'v1.0.0' }
  s.platform         = :ios, '13.0'
  s.source_files     = 'Library/**/*.{h,m}'
  s.requires_arc = false
end
