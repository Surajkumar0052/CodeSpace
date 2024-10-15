trigger CityPinCodeTrigger on Account (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){
        CityPinCodeHandler.getCityName(Trigger.new);
    }

}