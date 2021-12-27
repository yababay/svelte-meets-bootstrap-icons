svg_files=$(wildcard ./node_modules/bootstrap-icons/icons/*.svg)
svelte_files=$(notdir ${svg_files:.svg=.svelte})

all: $(svelte_files) 

%.svelte:
	$(file >  $@,<script>)
	$(file >> $@,    import image from "bootstrap-icons/icons/$(subst svelte,svg,$@)")
	$(file >> $@,    export let height = 32)
	$(file >> $@,    let width = height)
	$(file >> $@,    export let title = 'title')
	$(file >> $@,    const tag = `<svg xmlns="http://www.w3.org/2000/svg" width="$${width}" height="$${height}" fill="currentColor" class="bi" viewBox="0 0 16 16"><title>$${title}</title>`)
	$(file >> $@,</script>)
	$(file >> $@,{@html image.replace(re, tag)})

clean:
	@rm -rf *.svelte

