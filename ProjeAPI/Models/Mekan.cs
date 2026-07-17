using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace ProjeAPI.Models
{
    public class Mekan
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MekanID { get; set; }

        [Required(ErrorMessage = "Mekan adı zorunludur.")]
        [StringLength(100)]
        public string MekanAdi { get; set; } = string.Empty;

        [Required(ErrorMessage = "Şehir zorunludur.")]
        [StringLength(50)]
        public string Sehir { get; set; } = string.Empty;

        [Column(TypeName = "decimal(3,2)")]
        public decimal ZiyaretciPuani { get; set; }

        public DateTime EklenmeTarihi { get; set; } = DateTime.Now;
    }
}