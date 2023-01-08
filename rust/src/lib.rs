use gdnative::prelude::*;

fn init(handle: InitHandle) {
    handle.add_class::<HelloWorld>();
}

godot_init!(init);
