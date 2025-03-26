use llama_cpp_2::llama_backend::LlamaBackend;
use llama_cpp_2::model::LlamaModel;
use llama_cpp_2::model::params::LlamaModelParams;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        println!("Remember to pass a model path, you doofus!");
    }
    let model_path = &args[1];

    let backend = LlamaBackend::init().expect("Failed to initialize llama backend");
    let params = LlamaModelParams::default();
    let model =
        LlamaModel::load_from_file(&backend, model_path, &params).expect("Failed loading model");

    for i in 0..model.meta_count() {
        let key = model
            .meta_key_by_index(i)
            .expect("Could not find key at index");

        if key.starts_with("tokenizer.chat_template") {
            println!("\n--- {key} ---");
            let template = model
                .meta_val_str_by_index(i)
                .expect("Could not find value at index");
            let test_templ = model
                .meta_val_str(&key)
                .expect("Could not find value at key");
            assert_eq!(template, test_templ);
            println!("{template}");
        }
    }
}
