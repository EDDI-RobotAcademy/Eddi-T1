<template>
  <div>
    <product-register-form @submit="onSubmit"/>
  </div>
</template>

<script>
import ProductRegisterForm from "@/components/product/ProductRegisterForm";
export default {
  name: "ProductRegisterView",
  components: {ProductRegisterForm },
  methods: {
    onSubmit() {
      //등록
    }
  }
}
</script>

<style scoped>

</style>