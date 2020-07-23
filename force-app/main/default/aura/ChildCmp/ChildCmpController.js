({
    fireEvent: function(cmp, event, helper) {
        var eventToFire = cmp.getEvent("sampleCmpEvent");
        eventToFire.setParams({
            message: cmp.get("v.message")
        })
        eventToFire.fire();
    }
})