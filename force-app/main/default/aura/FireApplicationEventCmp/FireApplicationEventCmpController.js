({
    fireApplicationEvent: function(cmp, event) {
        var appEvent = $A.get("e.c:ApplicationEvent");
        appEvent.setParams({
            message : "An application event fired me. " + "It all happened so fast. Now, I'm everywhere!"
        });
        appEvent.fire();
    }
});