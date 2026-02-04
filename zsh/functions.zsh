# =============================================================================
# FUNCTIONS
# =============================================================================

# Update KUBECONFIG with all YAML files from ~/.kube and reload zshrc
update-kubeconfig() {
    local kube_dir="$HOME/.kube"
    
    if [[ ! -d "$kube_dir" ]]; then
        echo "❌ Error: $kube_dir directory not found"
        return 1
    fi
    
    # Find all .yaml and .yml files in .kube directory
    local configs=()
    while IFS= read -r file; do
        configs+=("$file")
    done < <(find "$kube_dir" -maxdepth 1 -type f \( -name "*.yaml" -o -name "*.yml" \) 2>/dev/null | sort)
    
    if [[ ${#configs[@]} -eq 0 ]]; then
        echo "⚠️  No YAML files found in $kube_dir"
        return 1
    fi
    
    # Join configs with colons
    local kubeconfig_value="${(j.:.)configs}"
    
    # Export the new KUBECONFIG
    export KUBECONFIG="$kubeconfig_value"
    
    echo "✅ Updated KUBECONFIG with ${#configs[@]} config(s):"
    printf "   - %s\n" "${configs[@]}"
    
    # Source zshrc
    echo "🔄 Reloading zshrc..."
    source ~/.zshrc
    
    echo "✅ Done!"
}
