<template>
  <div class="space-y-8">
    <!-- VS Code Installation Card -->
    <div class="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-8">
      <div class="flex items-center gap-4 mb-6">
        <div class="text-4xl grayscale">💻</div>
        <div>
          <h3 class="text-2xl font-bold text-gray-900 dark:text-gray-100">Visual Studio Code</h3>
          <p class="text-gray-600 dark:text-gray-400 text-lg">El editor de código principal</p>
        </div>
      </div>

      <div class="grid md:grid-cols-2 gap-6 mb-2">
        <div class="bg-gray-50 dark:bg-gray-950/50 rounded-lg p-5 border border-gray-100 dark:border-gray-800/60">
          <h4 class="font-semibold mb-3 flex items-center gap-2 text-gray-800 dark:text-gray-200">
            <span>🚀</span> Características
          </h4>
          <ul class="text-sm text-gray-600 dark:text-gray-400 space-y-2">
            <li>• IntelliSense avanzado</li>
            <li>• Debugging integrado</li>
            <li>• Terminal integrada</li>
            <li>• Control de versiones Git</li>
            <li>• Marketplace de extensiones</li>
          </ul>
        </div>

        <div class="bg-gray-50 dark:bg-gray-950/50 rounded-lg p-5 border border-gray-100 dark:border-gray-800/60 flex flex-col justify-center">
          <h4 class="font-semibold mb-3 flex items-center gap-2 text-gray-800 dark:text-gray-200">
            <span>⚡</span> Instalación rápida
          </h4>
          <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded p-3 font-mono text-sm flex items-center justify-between mb-3">
            <code class="text-gray-800 dark:text-gray-300">brew install --cask visual-studio-code</code>
            <button
              @click="copyToClipboard('brew install --cask visual-studio-code')"
              class="ml-2 p-1.5 rounded hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors text-gray-500 hover:text-gray-800 dark:hover:text-gray-200"
              title="Copiar comando"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
              </svg>
            </button>
          </div>
          <a
            href="https://code.visualstudio.com/"
            target="_blank"
            class="inline-flex items-center gap-1 text-sm text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-300 transition-colors"
          >
            Sitio oficial
            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
            </svg>
          </a>
        </div>
      </div>
    </div>

    <!-- Extensions Section -->
    <div class="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden">
      <!-- Header -->
      <div class="px-8 py-6 border-b border-gray-200 dark:border-gray-800">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-3">
              <span class="text-3xl grayscale">🔧</span>
              Extensiones Esenciales
            </h3>
            <p class="text-gray-500 dark:text-gray-400 mt-1 text-base">
              {{ totalExtensions }} extensiones organizadas por categoría
            </p>
          </div>
          <div class="text-right">
            <button
              @click="installAllExtensions"
              class="bg-gray-900 hover:bg-black dark:bg-gray-100 dark:hover:bg-white text-white dark:text-gray-900 px-6 py-2.5 rounded-lg text-sm font-medium transition-colors flex items-center gap-2"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
              </svg>
              Instalar Todas
            </button>
          </div>
        </div>
      </div>

      <!-- Category Tabs -->
      <div class="px-8 py-4 bg-gray-50/50 dark:bg-gray-950/50 border-b border-gray-200 dark:border-gray-800">
        <div class="flex flex-wrap gap-2">
          <button
            v-for="category in extensionCategories"
            :key="category"
            @click="selectedCategory = category"
            :class="[
              'px-4 py-2 rounded-lg text-sm font-medium transition-colors border',
              selectedCategory === category
                ? 'bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-400 border-blue-200 dark:border-blue-800/50'
                : 'bg-transparent text-gray-600 dark:text-gray-400 border-transparent hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-gray-200'
            ]"
          >
            {{ category }}
            <span class="ml-1.5 text-xs opacity-60">
              {{ getExtensionsByCategory(category).length }}
            </span>
          </button>
        </div>
      </div>

      <!-- Extensions Grid -->
      <div class="p-8">
        <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          <div
            v-for="extension in getExtensionsByCategory(selectedCategory)"
            :key="extension.id"
            class="bg-white dark:bg-gray-900 rounded-lg p-5 border border-gray-200 dark:border-gray-800 hover:border-blue-300 dark:hover:border-blue-700 transition-colors duration-200 group cursor-pointer flex flex-col"
            @click="toggleExtensionSelection(extension.id)"
          >
            <div class="flex items-start justify-between mb-3">
              <div class="flex items-center gap-3">
                <span class="text-2xl grayscale group-hover:grayscale-0 transition-all">{{ extension.icon }}</span>
                <div class="flex-1">
                  <h4 class="font-medium text-gray-900 dark:text-gray-100 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                    {{ extension.name }}
                  </h4>
                </div>
              </div>
              <div class="flex items-center gap-2">
                <!-- Selection checkbox -->
                <div
                  :class="[
                    'w-5 h-5 rounded border transition-colors duration-200 flex items-center justify-center',
                    selectedExtensions.has(extension.id)
                      ? 'bg-blue-600 border-blue-600'
                      : 'border-gray-300 dark:border-gray-600 group-hover:border-gray-400 dark:group-hover:border-gray-500 bg-transparent'
                  ]"
                >
                  <svg
                    v-if="selectedExtensions.has(extension.id)"
                    class="w-3 h-3 text-white"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path>
                  </svg>
                </div>
                <!-- Copy button -->
                <button
                  @click.stop="copyExtensionCommand(extension.id)"
                  class="p-1 rounded hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors opacity-0 group-hover:opacity-100 text-gray-400 hover:text-gray-700 dark:hover:text-gray-300"
                  title="Copiar ID"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                  </svg>
                </button>
              </div>
            </div>

            <p class="text-sm text-gray-500 dark:text-gray-400 mb-4 flex-grow">{{ extension.description }}</p>

            <div class="text-xs text-gray-400 dark:text-gray-500 font-mono truncate">
              {{ extension.id }}
            </div>
          </div>
        </div>

        <!-- Selection Summary -->
        <div v-if="selectedExtensions.size > 0" class="mt-8 bg-gray-50 dark:bg-gray-950/50 border border-gray-200 dark:border-gray-800 rounded-lg p-6">
          <div class="flex items-center justify-between mb-4">
            <div>
              <h4 class="font-medium text-gray-900 dark:text-gray-100 flex items-center gap-2">
                <span class="grayscale">📦</span>
                Seleccionadas ({{ selectedExtensions.size }})
              </h4>
            </div>
            <div class="flex gap-3 items-center">
              <button
                @click="clearSelection"
                class="text-gray-500 hover:text-gray-800 dark:hover:text-gray-200 text-sm transition-colors"
              >
                Limpiar
              </button>
              <button
                @click="installSelectedExtensions"
                class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
              >
                Copiar Comando
              </button>
            </div>
          </div>

          <!-- Command preview -->
          <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded p-4 font-mono text-sm">
            <div class="flex items-center justify-between mb-2">
              <span class="text-gray-500 dark:text-gray-400 text-xs uppercase tracking-wider">COMANDO COMPLETO</span>
              <button
                @click="copySelectedCommand"
                class="text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 transition-colors"
                title="Copiar comando"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
              </button>
            </div>
            <div class="text-gray-800 dark:text-gray-300 whitespace-pre-wrap max-h-32 overflow-y-auto">{{ selectedExtensionsCommand }}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Tips Section -->
    <div class="bg-gray-50 dark:bg-gray-950/50 rounded-xl border border-gray-200 dark:border-gray-800 p-6">
      <h4 class="font-medium text-gray-900 dark:text-gray-100 mb-4 flex items-center gap-2">
        <span class="grayscale">💡</span> Tips y Atajos
      </h4>
      <div class="grid md:grid-cols-2 gap-6 text-sm text-gray-600 dark:text-gray-400">
        <div class="space-y-3">
          <ul class="space-y-2">
            <li class="flex items-center gap-2">
              <code class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 px-1.5 py-0.5 rounded text-xs">Cmd+Shift+P</code>
              <span>Paleta de comandos</span>
            </li>
            <li class="flex items-center gap-2">
              <code class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 px-1.5 py-0.5 rounded text-xs">Cmd+P</code>
              <span>Búsqueda rápida</span>
            </li>
            <li class="flex items-center gap-2">
              <code class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 px-1.5 py-0.5 rounded text-xs">Cmd+`</code>
              <span>Terminal integrada</span>
            </li>
          </ul>
        </div>
        <div class="space-y-2">
          <p class="font-medium text-gray-700 dark:text-gray-300">Recomendaciones:</p>
          <ul class="space-y-1">
            <li>• Activa el <em>Auto Save</em> (onFocusChange)</li>
            <li>• Configura Prettier como formateador predeterminado</li>
            <li>• Usa "Format on Save" para mantener el código limpio</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { vscodeExtensions, extensionCategories } from '@/data/setupData'

const selectedCategory = ref('Esenciales')
const selectedExtensions = ref(new Set<string>())

const totalExtensions = computed(() => vscodeExtensions.length)

const getExtensionsByCategory = (category: string) => {
  return vscodeExtensions.filter(ext => ext.category === category)
}

const selectedExtensionsCommand = computed(() => {
  const extensions = Array.from(selectedExtensions.value)
  return extensions.map(id => `code --install-extension ${id}`).join(' && \\\n')
})

const copyToClipboard = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text)
  } catch (err) {
    console.error('Failed to copy text: ', err)
  }
}

const copyExtensionCommand = (extensionId: string) => {
  copyToClipboard(`code --install-extension ${extensionId}`)
}

const toggleExtensionSelection = (extensionId: string) => {
  if (selectedExtensions.value.has(extensionId)) {
    selectedExtensions.value.delete(extensionId)
  } else {
    selectedExtensions.value.add(extensionId)
  }
}

const clearSelection = () => {
  selectedExtensions.value.clear()
}

const installSelectedExtensions = () => {
  copyToClipboard(selectedExtensionsCommand.value)
}

const installAllExtensions = () => {
  const allCommand = vscodeExtensions.map(ext => `code --install-extension ${ext.id}`).join(' && \\\n')
  copyToClipboard(allCommand)
}

const copySelectedCommand = () => {
  copyToClipboard(selectedExtensionsCommand.value)
}
</script>
