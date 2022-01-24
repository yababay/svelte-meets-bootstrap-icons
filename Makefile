svg_files=$(wildcard ./node_modules/bootstrap-icons/icons/*.svg)
svelte_files=$(notdir ${svg_files:.svg=.svelte})

all: clean $(svelte_files) 

%.svelte:
	$(file >  $@,<script>)
	$(file >> $@,    import image from "bootstrap-icons/icons/$(subst svelte,svg,$@)")
	$(file >> $@,    export let size = 16')
	$(file >> $@,    const tag = `<symbol id="$(subst .svelte,,$@)" viewBox="0 0 $${size} $${size}">`)
	$(file >> $@,    const markup = image.replace(/<svg[^>]+>/, tag).replace('</svg>', '</symbol>'))
	$(file >> $@,</script>)
	$(file >> $@,{@html markup})

clean:
	@rm -rf *.svelte

