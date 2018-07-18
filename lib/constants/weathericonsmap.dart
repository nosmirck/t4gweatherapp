const iconMap =  {
  'owm-neutral-200':'thunderstorm', 
  'owm-neutral-201':'thunderstorm', 
  'owm-neutral-202':'thunderstorm', 
  'owm-neutral-210':'lightning', 
  'owm-neutral-211':'lightning', 
  'owm-neutral-212':'lightning', 
  'owm-neutral-221':'lightning', 
  'owm-neutral-230':'thunderstorm', 
  'owm-neutral-231':'thunderstorm', 
  'owm-neutral-232':'thunderstorm', 
  'owm-neutral-300':'sprinkle', 
  'owm-neutral-301':'sprinkle', 
  'owm-neutral-302':'rain', 
  'owm-neutral-310':'rain-mix', 
  'owm-neutral-311':'rain', 
  'owm-neutral-312':'rain', 
  'owm-neutral-313':'showers', 
  'owm-neutral-314':'rain', 
  'owm-neutral-321':'sprinkle', 
  'owm-neutral-500':'sprinkle', 
  'owm-neutral-501':'rain', 
  'owm-neutral-502':'rain', 
  'owm-neutral-503':'rain', 
  'owm-neutral-504':'rain', 
  'owm-neutral-511':'rain-mix', 
  'owm-neutral-520':'showers', 
  'owm-neutral-521':'showers', 
  'owm-neutral-522':'showers', 
  'owm-neutral-531':'storm-showers', 
  'owm-neutral-600':'snow', 
  'owm-neutral-601':'snow', 
  'owm-neutral-602':'sleet', 
  'owm-neutral-611':'rain-mix', 
  'owm-neutral-612':'rain-mix', 
  'owm-neutral-615':'rain-mix', 
  'owm-neutral-616':'rain-mix', 
  'owm-neutral-620':'rain-mix', 
  'owm-neutral-621':'snow', 
  'owm-neutral-622':'snow', 
  'owm-neutral-701':'showers', 
  'owm-neutral-711':'smoke', 
  'owm-neutral-721':'day-haze', 
  'owm-neutral-731':'dust', 
  'owm-neutral-741':'fog', 
  'owm-neutral-761':'dust', 
  'owm-neutral-762':'dust', 
  'owm-neutral-771':'cloudy-gusts', 
  'owm-neutral-781':'tornado', 
  'owm-neutral-800':'day-sunny', 
  'owm-neutral-801':'cloudy-gusts', 
  'owm-neutral-802':'cloudy-gusts', 
  'owm-neutral-803':'cloudy-gusts', 
  'owm-neutral-804':'cloudy', 
  'owm-neutral-900':'tornado', 
  'owm-neutral-901':'storm-showers', 
  'owm-neutral-902':'hurricane', 
  'owm-neutral-903':'snowflake-cold', 
  'owm-neutral-904':'hot', 
  'owm-neutral-905':'windy', 
  'owm-neutral-906':'hail', 
  'owm-neutral-957':'strong-wind', 
  'owm-day-200':'day-thunderstorm', 
  'owm-day-201':'day-thunderstorm', 
  'owm-day-202':'day-thunderstorm', 
  'owm-day-210':'day-lightning', 
  'owm-day-211':'day-lightning', 
  'owm-day-212':'day-lightning', 
  'owm-day-221':'day-lightning', 
  'owm-day-230':'day-thunderstorm', 
  'owm-day-231':'day-thunderstorm', 
  'owm-day-232':'day-thunderstorm', 
  'owm-day-300':'day-sprinkle', 
  'owm-day-301':'day-sprinkle', 
  'owm-day-302':'day-rain', 
  'owm-day-310':'day-rain', 
  'owm-day-311':'day-rain', 
  'owm-day-312':'day-rain', 
  'owm-day-313':'day-rain', 
  'owm-day-314':'day-rain', 
  'owm-day-321':'day-sprinkle', 
  'owm-day-500':'day-sprinkle', 
  'owm-day-501':'day-rain', 
  'owm-day-502':'day-rain', 
  'owm-day-503':'day-rain', 
  'owm-day-504':'day-rain', 
  'owm-day-511':'day-rain-mix', 
  'owm-day-520':'day-showers', 
  'owm-day-521':'day-showers', 
  'owm-day-522':'day-showers', 
  'owm-day-531':'day-storm-showers', 
  'owm-day-600':'day-snow', 
  'owm-day-601':'day-sleet', 
  'owm-day-602':'day-snow', 
  'owm-day-611':'day-rain-mix', 
  'owm-day-612':'day-rain-mix', 
  'owm-day-615':'day-rain-mix', 
  'owm-day-616':'day-rain-mix', 
  'owm-day-620':'day-rain-mix', 
  'owm-day-621':'day-snow', 
  'owm-day-622':'day-snow', 
  'owm-day-701':'day-showers', 
  'owm-day-711':'smoke', 
  'owm-day-721':'day-haze', 
  'owm-day-731':'dust', 
  'owm-day-741':'day-fog', 
  'owm-day-761':'dust', 
  'owm-day-762':'dust', 
  'owm-day-781':'tornado', 
  'owm-day-800':'day-sunny', 
  'owm-day-801':'day-cloudy-gusts', 
  'owm-day-802':'day-cloudy-gusts', 
  'owm-day-803':'day-cloudy-gusts', 
  'owm-day-804':'day-sunny-overcast', 
  'owm-day-900':'tornado', 
  'owm-day-902':'hurricane', 
  'owm-day-903':'snowflake-cold', 
  'owm-day-904':'hot', 
  'owm-day-906':'day-hail', 
  'owm-day-957':'strong-wind', 
  'owm-night-200':'night-alt-thunderstorm', 
  'owm-night-201':'night-alt-thunderstorm', 
  'owm-night-202':'night-alt-thunderstorm', 
  'owm-night-210':'night-alt-lightning', 
  'owm-night-211':'night-alt-lightning', 
  'owm-night-212':'night-alt-lightning', 
  'owm-night-221':'night-alt-lightning', 
  'owm-night-230':'night-alt-thunderstorm', 
  'owm-night-231':'night-alt-thunderstorm', 
  'owm-night-232':'night-alt-thunderstorm', 
  'owm-night-300':'night-alt-sprinkle', 
  'owm-night-301':'night-alt-sprinkle', 
  'owm-night-302':'night-alt-rain', 
  'owm-night-310':'night-alt-rain', 
  'owm-night-311':'night-alt-rain', 
  'owm-night-312':'night-alt-rain', 
  'owm-night-313':'night-alt-rain', 
  'owm-night-314':'night-alt-rain', 
  'owm-night-321':'night-alt-sprinkle', 
  'owm-night-500':'night-alt-sprinkle', 
  'owm-night-501':'night-alt-rain', 
  'owm-night-502':'night-alt-rain', 
  'owm-night-503':'night-alt-rain', 
  'owm-night-504':'night-alt-rain', 
  'owm-night-511':'night-alt-rain-mix', 
  'owm-night-520':'night-alt-showers', 
  'owm-night-521':'night-alt-showers', 
  'owm-night-522':'night-alt-showers', 
  'owm-night-531':'night-alt-storm-showers', 
  'owm-night-600':'night-alt-snow', 
  'owm-night-601':'night-alt-sleet', 
  'owm-night-602':'night-alt-snow', 
  'owm-night-611':'night-alt-rain-mix', 
  'owm-night-612':'night-alt-rain-mix', 
  'owm-night-615':'night-alt-rain-mix', 
  'owm-night-616':'night-alt-rain-mix', 
  'owm-night-620':'night-alt-rain-mix', 
  'owm-night-621':'night-alt-snow', 
  'owm-night-622':'night-alt-snow', 
  'owm-night-701':'night-alt-showers', 
  'owm-night-711':'smoke', 
  'owm-night-721':'day-haze', 
  'owm-night-731':'dust', 
  'owm-night-741':'night-fog', 
  'owm-night-761':'dust', 
  'owm-night-762':'dust', 
  'owm-night-781':'tornado', 
  'owm-night-800':'night-clear', 
  'owm-night-801':'night-alt-cloudy-gusts', 
  'owm-night-802':'night-alt-cloudy-gusts', 
  'owm-night-803':'night-alt-cloudy-gusts', 
  'owm-night-804':'night-alt-cloudy', 
  'owm-night-900':'tornado', 
  'owm-night-902':'hurricane', 
  'owm-night-903':'snowflake-cold', 
  'owm-night-904':'hot', 
  'owm-night-906':'night-alt-hail', 
  'owm-night-957':'strong-wind', 
}; 