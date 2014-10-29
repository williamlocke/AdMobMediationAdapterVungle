Pod::Spec.new do |s|
  s.name         = "AdMobMediationAdapterVungle"

  s.version      = "0.0.1"

  s.summary      = "AdMobMediationAdapterVungle."

  s.homepage     = "https://github.com/williamlocke/AdMobMediationAdapterVungle"

	s.license      = { :type => 'FreeBSD', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/williamlocke/AdMobMediationAdapterVungle.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  
  s.source_files =  'Classes/AdMobMediationAdapterVungle/*.[h,m]'
  
  s.frameworks = 'QuartzCore', 'CoreText', 'VungleSDK'
  
  s.requires_arc = true
  
	s.dependency 'Google-AdMob-Ads-SDK'
	s.dependency 'Vungle'
	
  
end
