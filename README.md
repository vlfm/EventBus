EventBus delivers events to subscribers.

Any object can be an event. Class of event object is type of event.

Any object can be a subscriber for any event type.
Subscriber must implement event handle method for each event type it is subscribed to.
Event handle method receives event object of corresponding type.

Signature of event handle method is 'handleABC:', where ABC is type of event.
For example, if object wants to subscribe to 'Foo' event, it must have 'handleFoo:' method implemented.

EventBus does not retain its subscribers.