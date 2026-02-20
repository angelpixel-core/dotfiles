use std::env;
use std::fs;
use std::path::PathBuf;
use regex::Regex;

fn main() {
    let args: Vec<String> = env::args().collect();
    let input_path = PathBuf::from(&args[1]);
    let out_dir = PathBuf::from(&args[2]);
    let log_path = PathBuf::from(&args[3]);

    let content = fs::read_to_string(&input_path).expect("No se pudo leer el archivo");
    let task_blocks = content.split("---\n").collect::<Vec<&str>>();
    let tarea_regex = Regex::new(r"### Tarea\s+([0-9a-z]+):\s+(.*)").unwrap();

    let mut log = String::new();

    for block in task_blocks {
        if let Some(caps) = tarea_regex.captures(block) {
            let id = &caps[1];
            let title = &caps[2].replace(|c: char| !c.is_alphanumeric(), "_");
            let filename = format!("{}-{}.md", id, title);
            let filepath = out_dir.join(&filename);
            fs::write(&filepath, block.trim()).expect("Error al escribir archivo");
            println!("📝 {}", filename);
            log.push_str(&format!("📝 {}\n", filename));
        }
    }

    fs::write(&log_path, log).expect("Error al escribir log");
    println!("✅ Exportación finalizada.");
}
