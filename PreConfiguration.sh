#!/bin/bash
set +e
echo ""
echo -e "\e[92mConfiguration-Utility\e[0m"
echo ""
echo "_________________________________________________________________"
echo " "
echo " "
echo -e "\e[4;92mPlease select your Display-Type.\e[0;0m"
echo " "
echo " "
echo "_________________________________________________________________"
echo -e "\e[93mValid selections are:\e[0m"
echo -e "1 -> for \e[92mssd1306\e[0m"
echo -e "2 -> for \e[92mssd1322\e[0m"
echo -e "\e[93m---> \e[0m"
getDisplayType() {
  read -p "Enter your decision: " DisplayNumber
  case "$DisplayNumber" in
    1)
      sed -i 's/\(DisplayTechnology = \)\(.*\)/\1"'"i2c1306"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py
      echo " "
      echo -e "\e[92mSet Display-Type as ssd1306\e[0m"
      return 0
      ;;
    2)
      sed -i 's/\(DisplayTechnology = \)\(.*\)/\1"'"spi1322"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py
      echo " "
      echo -e "\e[92mSet Display-Type as ssd1322\e[0m"
      return 0
      ;;  
    *)
      printf %s\\n "Please enter '1' or '2'"
      return 1
      ;;
  esac
}
until getDisplayType; do : ; done #
echo "_________________________________________________________________" #
echo " " #
getScreenLayout1306() { 
      sed -i 's/\(NowPlayingLayout = \)\(.*\)/\1"'"Progress-Bar"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo "Progress-Bar" > /home/volumio/Volumio-Oled-UI/ConfigurationFiles/LayoutSet.txt #
      echo " " #
      echo -e "\e[92mSet Layout as Progress-Bar\e[0m" #
      return 0 #
} #
getScreenLayout1322() { 
      sed -i 's/\(NowPlayingLayout = \)\(.*\)/\1"'"No-Spectrum"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py
      echo "No-Spectrum" > /home/volumio/Volumio-Oled-UI/ConfigurationFiles/LayoutSet.txt
      echo " "
      echo -e "\e[92mSet Screen Layout as No-Spectrum\e[0m"
      return 0
}
if [[ $DisplayNumber -eq 1 ]];
then
    sed -i 's/\(NowPlayingLayout = \)\(.*\)/\1"'"Progress-Bar"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py
    echo "Progress-Bar" > /home/volumio/Volumio-Oled-UI/ConfigurationFiles/LayoutSet.txt
fi
if [[ $DisplayNumber -eq 2 ]];
then
    sed -i 's/\(NowPlayingLayout = \)\(.*\)/\1"'"No-Spectrum"'"/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py
    echo "No-Spectrum" > /home/volumio/Volumio-Oled-UI/ConfigurationFiles/LayoutSet.txt
fi
echo "_________________________________________________________________ " #
echo " " #
echo -e "\e[4;92mShould the Display be rotated? \e[0;0m" #
echo " " #
echo "_____________________ " #
echo -e "\e[93mValid selections are:\e[0m" #
echo -e "1 -> \e[92mDisplay not rotated\e[0m" #
echo -e "2 -> \e[92mDisplay rotated 180 degrees \e[0m" #
echo -e "\e[93m---> \e[0m" #
getDisplayRotation() { #
  read -p "Enter your decision: " RotationNumber #
  case "$RotationNumber" in #
    1) #    
      sed -i 's/\(oledrotation = \)\(.*\)/\10/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      echo " " #
      echo -e "\e[92mSet Display-Rotation to zero Rotation.\e[0m" #
      return 0 #
      ;; #
    2) #
      sed -i 's/\(oledrotation = \)\(.*\)/\12/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      echo -e "\e[92mSet Display-Rotation to 180 degrees Rotation\e[0m" #
      return 0 #
      ;; #         
    *) #
      printf %s\\n "Please enter '1' or '2'" #
      return 1 #
      ;; #
  esac #
} #
until getDisplayRotation; do : ; done #
echo "_________________________________________________________________ " #
echo " " #
echo -e "\e[4;92mDo you use the Standby-Circuit?\e[0;0m" #
echo " " #
echo -e "\e[93mMore informations here: \e[0m" #
echo -e "\e[93mhttps://github.com/Maschine2501/Volumio-Oled-UI/wiki/Standby-Module \e[0;0m" #
echo " " #
echo -e "\e[4;91mWARNING: Do not select YES if you do not have connected the circuit!!!\e[0;0m" #
echo " " #
echo "______________________ " #
echo -e "\e[93mValid selections are:\e[0m" #
echo -e "1 -> \e[92mYes\e[0m" #
echo -e "2 -> \e[91mNo\e[0m" #
echo -e "\e[93m----> \e[0m" #
StandbyUsage() { #
  read -p "Enter your decision: " StandbyNumber #
  case "$StandbyNumber" in #
    1) #   
      sed -i 's/\(StandbyActive = \)\(.*\)/\1True/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo "dtoverlay=gpio-shutdown" >> /boot/userconfig.txt #
      echo " " #
      echo -e "\e[92mActivated Standby-Function\e[0m" #
      return 0 #
      ;; #
    2) #
      sed -i 's/\(StandbyActive = \)\(.*\)/\1False/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      echo -e "\e[92mDeactivated Standby-Function\e[0m" #
      return 0 #
      ;; #         
    *) #
      printf %s\\n "Please enter '1' or '2'" #
      return 1 #
      ;; #
  esac #
} #
until StandbyUsage; do : ; done #
echo "_________________________________________________________________ " #
echo " " #
echo -e "\e[4;92mPlease select your Button- / Rotary- configuration\e[0;0m" #
echo " " #
echo -e "\e[93m*standard*-configuration means a conection like this: \e[0m" #
echo -e "\e[93mhttps://raw.githubusercontent.com/Maschine2501/Volumio-Oled-UI/master/wiki/wiring/Wiring.jpg\e[0m" #
echo " " #
echo "_____________________" #
echo -e "\e[93mValid selections are:\e[0m" #
echo -e "\e[92m1 -> standard\e[0m" #
echo -e "\e[91m2 -> custom\e[0m" #
echo -e "\e[93m--->\e[0m" #
getGPIONumberA() { #
  read -p "Please enter the BCM Number for Button A :" ANumber #
  case "$ANumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledBtnA = \)\(.*\)/\1$ANumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberB() { #
  read -p "Please enter the BCM Number for Button B :" BNumber #
  case "$BNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledBtnB = \)\(.*\)/\1$BNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberC() { #
  read -p "Please enter the BCM Number for Button C :" CNumber #
  case "$CNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledBtnC = \)\(.*\)/\1$CNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberD() { #
  read -p "Please enter the BCM Number for Button D :" DNumber #
  case "$DNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledBtnD = \)\(.*\)/\1$DNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberL() { #
  read -p "Please enter the BCM Number for Rotary-Left :" LNumber #
  case "$LNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledRtrLeft = \)\(.*\)/\1$LNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberR() { #
  read -p "Please enter the BCM Number for Rotary-Right :" RNumber #
  case "$RNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledRtrRight = \)\(.*\)/\1$RNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
} #
getGPIONumberRB() { #
  read -p "Please enter the BCM Number for Rotary-Button :" RBNumber #
  case "$RBNumber" in #
    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27) #    
      sed -i "s/\(oledRtrBtn = \)\(.*\)/\1$RBNumber/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Number was out of range...(must be 0-27)" #
      return 1 #
      ;; #
  esac #
}
getButtonLayout() { #
  read -p "Enter your decision: " ButonNumber #
  case "$ButonNumber" in #
    1) #    
      sed -i 's/\(oledBtn = \)\(.*\)/\14/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      sed -i 's/\(oledBtn = \)\(.*\)/\117/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      sed -i 's/\(oledBtn = \)\(.*\)/\15/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      sed -i 's/\(oledBtn = \)\(.*\)/\16/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      sed -i 's/\(oledRtrLeft = \)\(.*\)/\122/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      sed -i 's/\(oledRtrRight = \)\(.*\)/\123/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py # 
      sed -i 's/\(oledRtrBtn = \)\(.*\)/\127/' /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #  
      echo " " #
      echo -e "\e[92mSet standard-buttonlayout\e[0m" #
      return 0 #
      ;; #
    2) #
      echo -e "\e[4;92mPlease Enter the BCM-(GPIO) Number for each Button.\e[0;0m" #
      echo " " #
      echo -e "\e[93mFor BCM2 enter 2, for BCM17 enter 17...\e[0m" #
      echo -e "\e[93mBCM-list: https://de.pinout.xyz/#\e[0m" #
      echo " " #
      echo -e "\e[91mthe input is not filtered!!!\e[0m" #
      echo -e "\e[91m-> if you enter something wrong, something wrong will happen!\e[0m" #
      echo " " #
      until getGPIONumberA; do : ; done #
      until getGPIONumberB; do : ; done #
      until getGPIONumberC; do : ; done #
      until getGPIONumberD; do : ; done #     
      until getGPIONumberL; do : ; done #
      until getGPIONumberR; do : ; done #
      until getGPIONumberRB; do : ; done #      
      echo " " #
      echo -e "\e[92mSet custom-buttonlayout\e[0m" #
      return 0 #
      ;; #        
    *) #
      printf %s\\n "Please enter '1' or '2'" #
      return 1 #
      ;; #
  esac #
} #
until getButtonLayout; do : ; done #
echo "_________________________________________________________________" #
echo " " #
echo -e "\e[4;92mPlease enter a Value for Pause -> to -> Stop -Time.\e[0;0m" #
echo " " #
echo -e "\e[93mValue is in Seconds = 15 = 15 Seconds.\e[0m" #
echo -e "\e[93mAfter this time, while playback is paused, player will Stop and return to Standby-Screen.\e[0;0m" #
echo " " #
echo "____________________________________________ " #
echo -e "\e[93mValid values are numbers between 1 and 86400\e[0m" #
echo -e "\e[93m86400 seconds are 24 hours...\e[0m" #
echo " " #
getPlay2PauseTime() { #
  read -p "Enter a Time (in seconds): " Play2PauseT #
  case "$Play2PauseT" in #
    [1-9]|[1-9][0-9]|[1-9][0-9][0-9]|[1-9][0-9][0-9][0-9]|[1-8][0-6][0-3][0-9][0-9]|86400) #     
      sed -i "s/\(oledPause2StopTime = \)\(.*\)/\1$Play2PauseT.0/" /home/volumio/Volumio-Oled-UI/ConfigurationFiles/PreConfiguration.py #
      echo " " #
      echo -n "Set Play-to-Pause timer to "; echo -n "${Play2PauseT} "; echo -n "seconds" #
      return 0 #
      ;; #
    *) #
      printf %s\\n "Please enter a number between '1' and '86400'" #
      return 1 #
      ;; #
  esac #
} #
until getPlay2PauseTime; do : ; done #
echo " " #
echo " " #
echo " " #
echo " " #
echo -e "\e[4;92mConfiguration has finished, congratulations!\e[0;0m" #
echo " " #
echo " " #
echo -e "\e[93mPlease have a look in the Installation instructions to finish setup.\e[0m" #                                                                                                                      
echo " " #
echo -e "\e[93mhttps://github.com/Maschine2501/Volumio-Oled-UI/wiki/Installation-Steps-(for-Python3.8.5-Version---Bash-Script)\e[0m" #
echo " " #
echo " " #
echo -e "\e[25;91mIf you use CAVA/Spectrum: \e[0;0m" #
echo " " #
echo -e "\e[91mPlease set Audio-Output to HDMI or Headphones and save setting.\e[0m" #
echo -e "\e[91mNow Select your DAC/Playback device and save aggain.\e[0m" #
exit 0 #